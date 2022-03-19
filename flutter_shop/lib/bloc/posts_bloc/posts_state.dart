part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoaded extends PostsState {
  PostsLoaded();
}

class PostsUpdated extends PostsState {
  PostsUpdated();
}

class PostsFinded extends PostsState {
  late Map post;
  PostsFinded({required this.post});
}
