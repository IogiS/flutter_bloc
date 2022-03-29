part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class FindProduct extends ProductsEvent {
  late final barcode;
  FindProduct({required this.barcode});
}

class ReduceCountProduct extends ProductsEvent {
  late final barcode;
  late final reduseBy;
  ReduceCountProduct({required this.barcode, required this.reduseBy});
}

class AddCountProduct extends ProductsEvent {
  late final barcode;
  late final reduseBy;
  AddCountProduct({required this.barcode, required this.reduseBy});
}

class AddProduct extends ProductsEvent {
  late final barcode;
  late final name;
  late final url_img;
  late final count;
  late final price;
  AddProduct(
      {required this.barcode,
      required this.name,
      required this.url_img,
      required this.count,
      required this.price});
}
