part of 'albums_bloc.dart';

@immutable
abstract class AlbumsState {
  const AlbumsState();
}

class AlbumsInitial extends AlbumsState {}

class AlbumsLoaded extends AlbumsState {
  const AlbumsLoaded();
}

class AlbumsUpdated extends AlbumsState {
  AlbumsUpdated();
}
