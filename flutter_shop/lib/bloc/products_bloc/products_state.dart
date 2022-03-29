part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductFinded extends ProductsState {
  late List product;
  ProductFinded({required this.product});
}

class ProductNotFinded extends ProductsState {
  ProductNotFinded();
}

class ProductReduseImposible extends ProductsState {
  ProductReduseImposible();
}

class ProductReduseSuccessfully extends ProductsState {
  ProductReduseSuccessfully();
}

class ProductAddFailed extends ProductsState {
  ProductAddFailed();
}

class ProductAddSuccessfully extends ProductsState {
  ProductAddSuccessfully();
}
