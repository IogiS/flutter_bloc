part of 'albums_bloc.dart';

@immutable
abstract class AlbumsState {
  const AlbumsState();
}

class AlbumsInitial extends AlbumsState {}

class AlbumsLoaded extends AlbumsState {
  const AlbumsLoaded();
}

class AlbumsLoadFailed extends AlbumsState {
  const AlbumsLoadFailed();
}

class AlbumsUpdated extends AlbumsState {
  AlbumsUpdated();
}

class AlbumsEnded extends AlbumsState {
  AlbumsEnded();
}

class AlbumsFinded extends AlbumsState {
  late Map album;
  AlbumsFinded({required this.album});
}
