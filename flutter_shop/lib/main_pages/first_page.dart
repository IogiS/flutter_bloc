import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/albums_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:page_transition/page_transition.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

ScrollController _scrollController = ScrollController();
bool isLoadingHorizontal = false;
@override
State<StatefulWidget> createState() {
  // TODO: implement createState
  throw UnimplementedError();
}

class _FirstPageState extends State<FirstPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    AlbumsBloc().add(LoadAlbums());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AlbumsBloc, AlbumsState>(
            listener: (context, AlbumsState state) {
      if (state is AlbumsUpdated) {}
    }, child: BlocBuilder<AlbumsBloc, AlbumsState>(
      builder: (context, state) {
        if (state is AlbumsInitial) {
          return const CircularProgressIndicator(color: Colors.blue);
        }
        return cardList();
      },
    )));
  }

  Future<void> _refresh() {
    BlocProvider.of<AlbumsBloc>(context).add(LoadAlbums());
    return Future.delayed(Duration(seconds: 0, milliseconds: 2000));
  }

  Widget card(int index) {
    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: Scaffold(
                      appBar: AppBar(
                        title: const Text('card'),
                      ),
                      body: card(index)),
                  inheritTheme: true,
                  ctx: context),
            ),
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
