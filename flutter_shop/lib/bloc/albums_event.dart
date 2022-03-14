part of 'albums_bloc.dart';

@immutable
abstract class AlbumsEvent extends Equatable {
  const AlbumsEvent();

  @override
  List<Object> get props => [];
}

class LoadAlbums extends AlbumsEvent {}
