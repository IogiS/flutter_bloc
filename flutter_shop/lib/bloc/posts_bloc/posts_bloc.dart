import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  late List posts = [];
  PostsBloc() : super(PostsInitial()) {
    on<LoadPosts>((event, emit) async {
      late http.Response response;
      try {
        final uri = Uri.parse('https://jsonplaceholder.typicode.com/Posts');
        response = await http.get(
          uri,
          headers: {
            'Content-type': 'application/json;charset=UTF-8',
            'charset': 'UTF-8',
          },
        );
      } catch (e) {
        print(e);
        throw e;
      }
      posts = jsonDecode(response.body).sublist(0, 11);
      emit(PostsLoaded());
    });
    on<LazyLoadPosts>((event, emit) async {
      late http.Response response;
      try {
        final uri = Uri.parse('https://jsonplaceholder.typicode.com/Posts');
        response = await http.get(
          uri,
          headers: {
            'Content-type': 'application/json;charset=UTF-8',
            'charset': 'UTF-8',
          },
        );
        if (posts.length + 10 > 100) {
          posts = jsonDecode(response.body);
          emit(PostEnded());
        } else {
          posts = jsonDecode(response.body).sublist(0, posts.length + 10);
          emit(PostsUpdated());
        }
      } catch (e) {
        print(e);
        throw e;
      }
    });
    on<FindPosts>((event, emit) async {
      late http.Response response;
      try {
        final uri = Uri.parse(
            'https://jsonplaceholder.typicode.com/posts/${event.index}');
        response = await http.get(
          uri,
          headers: {
            'Content-type': 'application/json;charset=UTF-8',
            'charset': 'UTF-8',
          },
        );
      } catch (e) {
        print(e);
        throw e;
      }
      var post = jsonDecode(response.body);
      emit(PostsFinded(post: post));
    });
  }
}
