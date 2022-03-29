import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';

import 'package:http/http.dart' as http;
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    const apiKey = 'AIzaSyBFM7lRU4J4jMUEl9m809TLT1yo3486f10';
    const projectId = 'flutter-desktop-a28ea';
    Firestore.initialize(projectId);

    on<FindProduct>((event, emit) async {
      try {
        CollectionReference goodCollection =
            Firestore.instance.collection('products');
        final product = await goodCollection
            .where('barcode', isEqualTo: '${event.barcode}')
            .get();
        if (product.isNotEmpty) {
          emit(ProductFinded(product: product));
        } else {
          emit(ProductNotFinded());
        }
      } catch (e) {
        throw e;
      }
    });
    on<ReduceCountProduct>((event, emit) async {
      try {
        CollectionReference goodCollection =
            Firestore.instance.collection('products');
        final product = await goodCollection
            .where('barcode', isEqualTo: '${event.barcode}')
            .get();
        int newCount =
            int.parse(product.single['count']) - int.parse(event.reduseBy);
        if (newCount > 0) {
          goodCollection
              .document(product.single.id)
              .update({'count': '$newCount'});
          emit(ProductReduseSuccessfully());
        } else {
          emit(ProductReduseImposible());
        }
      } catch (e) {
        throw e;
      }
    });
    on<AddCountProduct>((event, emit) async {
      try {
        CollectionReference goodCollection =
            Firestore.instance.collection('products');
        final product = await goodCollection
            .where('barcode', isEqualTo: '${event.barcode}')
            .get();
        int newCount =
            int.parse(product.single['count']) + int.parse(event.reduseBy);
        if (newCount > 0) {
          goodCollection
              .document(product.single.id)
              .update({'count': '$newCount'});
          emit(ProductReduseSuccessfully());
        } else {
          emit(ProductReduseImposible());
        }
      } catch (e) {
        throw e;
      }
    });
    on<AddProduct>((event, emit) async {
      try {
        CollectionReference goodCollection =
            Firestore.instance.collection('products');
        goodCollection.add({
          'barcode': event.barcode,
          'name': event.name,
          'img_url': event.url_img,
          'count': event.count,
          'price': event.price,
        });
        emit(ProductAddSuccessfully());
      } catch (e) {
        emit(ProductAddFailed());
        throw e;
      }
    });
  }
}
