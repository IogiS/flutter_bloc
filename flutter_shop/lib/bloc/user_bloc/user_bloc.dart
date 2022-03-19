import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late Map user = {};
  UserBloc() : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      late http.Response response;
      try {
        final uri = Uri.parse('https://jsonplaceholder.typicode.com/users/3');
        response = await http.get(
          uri,
          headers: {
            'Content-type': 'application/json;charset=UTF-8',
            'charset': 'UTF-8',
          },
        );
        user = jsonDecode(response.body);
        emit(UserLoaded());
      } catch (e) {
        print(e);
        throw e;
      }
    });
  }
}
