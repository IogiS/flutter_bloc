part of 'albums_bloc.dart';

@immutable
abstract class AlbumsEvent {
  const AlbumsEvent();
}

class LoadAlbums extends AlbumsEvent {}

class LazyLoadAlbums extends AlbumsEvent {}

class FindAlbums extends AlbumsEvent {
  late final index;
  FindAlbums({required this.index});
}
