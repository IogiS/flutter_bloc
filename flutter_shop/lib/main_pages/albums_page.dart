import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/albums_bloc/albums_bloc.dart';
import 'package:flutter_shop/ui/navigation_ui.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:page_transition/page_transition.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

ScrollController _scrollController = ScrollController();
bool isLoadingHorizontal = false;
@override
State<StatefulWidget> createState() {
  // TODO: implement createState
  throw UnimplementedError();
}

class _AlbumsPageState extends State<AlbumsPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AlbumsBloc, AlbumsState>(
            listener: (context, AlbumsState state) {
      if (state is AlbumsFinded) {
        Navigator.pushNamed(context, '/page3',
            arguments: {'index': state.album['id']});
      }
    }, child: BlocBuilder<AlbumsBloc, AlbumsState>(
      builder: (context, state) {
        if (state is AlbumsInitial) {
          return const CircularProgressIndicator(color: Colors.blue);
        }

        if (state is AlbumsLoadFailed) {
          return const Center(
            child: Text('Something went wrong!'),
          );
        } else {
          return cardList();
        }
      },
    )));
  }

  Future<void> _refresh() {
    BlocProvider.of<AlbumsBloc>(context).add(LoadAlbums());
    return Future.delayed(Duration(seconds: 0, milliseconds: 1000));
  }

  Widget card(int index) {
    return GestureDetector(
        onTap: () =>
            BlocProvider.of<AlbumsBloc>(context).add(FindAlbums(index: index)),
        child: Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.album),
                  subtitle: Text(BlocProvider.of<AlbumsBloc>(context)
                      .albums[index]['title']
                      .toString()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: Text(BlocProvider.of<AlbumsBloc>(context)
                          .albums[index]['id']
                          .toString()),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('LISTEN'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget cardList() {
    return SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            child: LazyLoadScrollView(
                onEndOfPage: () =>
                    BlocProvider.of<AlbumsBloc>(context).add(LazyLoadAlbums()),
                child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.builder(
                        key: new PageStorageKey('myListView'),
                        padding: const EdgeInsets.all(8),
                        itemCount:
                            BlocProvider.of<AlbumsBloc>(context).albums.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index ==
                              BlocProvider.of<AlbumsBloc>(context)
                                      .albums
                                      .length -
                                  1) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return card(index);
                          }
                        })))));
  }
}
