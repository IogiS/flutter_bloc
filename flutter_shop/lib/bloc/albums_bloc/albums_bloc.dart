import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  late List albums = [];
  AlbumsBloc() : super(AlbumsInitial()) {
    on<LoadAlbums>((event, emit) async {
      late http.Response response;
      try {
        final uri = Uri.parse('https://jsonplaceholder.typicode.com/albums');
        response = await http.get(
          uri,
          headers: {
            'Content-type': 'application/json;charset=UTF-8',
            'charset': 'UTF-8',
          },
        );
        albums = jsonDecode(response.body).sublist(0, 11);
        emit(AlbumsLoaded());
      } catch (e) {
        emit(AlbumsLoadFailed());
        throw e;
      }
    });
    on<LazyLoadAlbums>((event, emit) async {
      late http.Response response;
      try {
        final uri = Uri.parse('https://jsonplaceholder.typicode.com/albums');
        response = await http.get(
          uri,
          headers: {
            'Content-type': 'application/json;charset=UTF-8',
            'charset': 'UTF-8',
          },
        );

        if (albums.length + 10 > 100) {
          albums = jsonDecode(response.body);
          emit(AlbumsEnded());
        } else {
          albums = jsonDecode(response.body).sublist(0, albums.length + 10);
          emit(AlbumsUpdated());
        }
      } catch (e) {
        print(e);
        throw e;
      }
    });

    on<FindAlbums>((event, emit) async {
      late http.Response response;
      try {
        final uri = Uri.parse(
            'https://jsonplaceholder.typicode.com/albums/${event.index}');
        response = await http.get(
          uri,
          headers: {
            'Content-type': 'application/json;charset=UTF-8',
            'charset': 'UTF-8',
          },
        );
        var album = jsonDecode(response.body);
        emit(AlbumsFinded(album: album));
      } catch (e) {
        print(e);
        throw e;
      }
    });
  }
}
