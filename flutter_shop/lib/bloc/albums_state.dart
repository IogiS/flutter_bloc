part of 'albums_bloc.dart';

@immutable
abstract class AlbumsState extends Equatable {
  const AlbumsState();

  @override
  List<Object> get props => [];
}

class AlbumsInitial extends AlbumsState {}

class AlbumsLoaded extends AlbumsState {
  final List<Albums> albums;

  const AlbumsLoaded({required this.albums});

  @override
  List<Object> get props => [albums];
}
