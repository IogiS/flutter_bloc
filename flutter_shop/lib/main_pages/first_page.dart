import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/albums_bloc.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

@override
State<StatefulWidget> createState() {
  // TODO: implement createState
  throw UnimplementedError();
}

void initState() {
  AlbumsBloc().add(LoadAlbums());
}

class _FirstPageState extends State<FirstPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AlbumsBloc, AlbumsState>(
          builder: (context, state) {
            if (state is AlbumsInitial) {
              return const CircularProgressIndicator(color: Colors.blue);
            } else {
              return const Text('HO');
            }
          },
        ),
      ),
    );
  }
}
