import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop/models/albums_model.dart';
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
      } catch (e) {
        print(e);
        throw e;
      }
      albums = jsonDecode(response.body).sublist(0, 10);
      emit(AlbumsLoaded());
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
      } catch (e) {
        print(e);
        throw e;
      }
      albums = jsonDecode(response.body).sublist(0, albums.length + 10);
      print(albums.length);
      emit(AlbumsUpdated());
    });
  }
}
