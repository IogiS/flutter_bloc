import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';

import 'package:http/http.dart' as http;
part 'goods_event.dart';
part 'goods_state.dart';

class GoodsBloc extends Bloc<GoodsEvent, GoodsState> {
  GoodsBloc() : super(GoodsInitial()) {
    const apiKey = 'AIzaSyBFM7lRU4J4jMUEl9m809TLT1yo3486f10';
    const projectId = 'flutter-desktop-a28ea';
    Firestore.initialize(projectId);

    on<GoodsEvent>((event, emit) async {
      try {
        CollectionReference goodCollection = Firestore.instance.collection('');
        final goods = await goodCollection.get();
        print(goods.single['barcode']);
      } catch (e) {
        throw e;
      }
    });
  }
}
