part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class LoadPosts extends PostsEvent {}

class LazyLoadPosts extends PostsEvent {}

class FindPosts extends PostsEvent {
  late final index;
  FindPosts({required this.index});
}
