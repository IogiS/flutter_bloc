import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/posts_bloc/posts_bloc.dart';
import 'package:flutter_shop/ui/navigation_ui.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<PostsBloc>(context).add(LoadPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<PostsBloc, PostsState>(
            listener: (context, PostsState state) {
      if (state is PostsFinded) {
        Navigator.pushNamed(context, '/page4',
            arguments: {'index': state.post['id']});
      }
    }, child: BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return cardList();
      },
    )));
  }

  Future<void> _refresh() {
    BlocProvider.of<PostsBloc>(context).add(LoadPosts());
    return Future.delayed(Duration(seconds: 0, milliseconds: 2000));
  }

  Widget card(int index) {
    return GestureDetector(
        onTap: () =>
            BlocProvider.of<PostsBloc>(context).add(FindPosts(index: index)),
        child: Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.post_add),
                  subtitle: Text(BlocProvider.of<PostsBloc>(context)
                      .posts[index]['body']
                      .toString()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: Text(BlocProvider.of<PostsBloc>(context)
                          .posts[index]['id']
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
                    BlocProvider.of<PostsBloc>(context).add(LazyLoadPosts()),
                child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.builder(
                        key: const PageStorageKey('myListView'),
                        padding: const EdgeInsets.all(8),
                        itemCount:
                            BlocProvider.of<PostsBloc>(context).posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index ==
                              BlocProvider.of<PostsBloc>(context).posts.length -
                                  1) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return card(index);
                          }
                        })))));
  }
}
