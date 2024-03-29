import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/albums_bloc/albums_bloc.dart';
import 'package:flutter_shop/bloc/posts_bloc/posts_bloc.dart';
import 'package:flutter_shop/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_shop/ui/navigation_ui.dart';
import 'main_pages/albums_page.dart';
import 'main_pages/posts_page.dart';
import 'main_pages/user_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AlbumsBloc()..add(LoadAlbums()),
          ),
          BlocProvider(
            create: (context) => PostsBloc()..add(LoadPosts()),
          ),
          BlocProvider(
            create: (context) => UserBloc()..add(LoadUser()),
          ),
        ],
        child: const MaterialApp(
          home: MyStatefulWidget(),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    PostsPage(),
    AlbumsPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter BLoC'),
        ),
        body: Navigator(
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext context) => BottomBarPageTransition(
                      builder: (_, index) =>
                          Center(child: _widgetOptions[index]),
                      currentIndex: _selectedIndex,
                      totalLength: _widgetOptions.length,
                      transitionType: TransitionType.slide,
                      transitionDuration: const Duration(milliseconds: 300),
                    );
                break;
              case '/page1':
                builder = (BuildContext context) => BottomBarPageTransition(
                      builder: (_, index) =>
                          Center(child: _widgetOptions[index]),
                      currentIndex: _selectedIndex,
                      totalLength: _widgetOptions.length,
                      transitionType: TransitionType.slide,
                      transitionDuration: const Duration(milliseconds: 300),
                    );
                break;
              case '/page3':
                builder = (BuildContext context) => BottomBarPageTransition(
                      builder: (_, index) => Center(
                          child: Center(
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.album),
                                subtitle: Text(
                                    BlocProvider.of<AlbumsBloc>(context)
                                        .albums[(settings.arguments
                                                as Map)['index'] ??
                                            0]['title']
                                        .toString()),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: Text(
                                        BlocProvider.of<AlbumsBloc>(context)
                                            .albums[(settings.arguments
                                                    as Map)['index'] ??
                                                0]['id']
                                            .toString()),
                                    onPressed: () {/* ... */},
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    child: const Text('Back'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                      currentIndex: _selectedIndex,
                      totalLength: _widgetOptions.length - 1,
                      transitionType: TransitionType.slide,
                      transitionDuration: const Duration(milliseconds: 300),
                    );
                break;
              case '/page4':
                builder = (BuildContext context) => BottomBarPageTransition(
                      builder: (_, index) => Center(
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.post_add),
                                subtitle: Text(
                                    BlocProvider.of<PostsBloc>(context)
                                        .posts[(settings.arguments
                                                as Map)['index'] ??
                                            0]['body']
                                        .toString()),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: Text(
                                        BlocProvider.of<PostsBloc>(context)
                                            .posts[(settings.arguments
                                                    as Map)['index'] ??
                                                0]['id']
                                            .toString()),
                                    onPressed: () => {},
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    child: const Text('Back'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      currentIndex: _selectedIndex,
                      totalLength: _widgetOptions.length,
                      transitionType: TransitionType.slide,
                      transitionDuration: const Duration(milliseconds: 300),
                    );
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            // You can also return a PageRouteBuilder and
            // define custom transitions between pages
            return MaterialPageRoute(
              builder: builder,
              settings: settings,
            );
          },
        ),
        bottomNavigationBar: NavigationBarUI(
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                {
                  _selectedIndex = index;
                }
              });
            }));
  }
}
