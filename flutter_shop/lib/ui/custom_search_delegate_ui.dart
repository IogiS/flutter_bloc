import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/products_bloc/products_bloc.dart';
import '../main_pages/product.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<ProductsBloc>(context).add(FindProduct(barcode: query));
    return Scaffold(
      body: BlocListener<ProductsBloc, ProductsState>(listener:
          (context, ProductsState state) {
        if (state is ProductReduseImposible) {
          const snackBar = SnackBar(
            content: Text('Количество товара не может быть меньше нуля'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is ProductReduseSuccessfully) {
          const snackBar = SnackBar(
            content: Text('Успешно'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pop();
        }
      }, child:
          BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
        if (state is ProductFinded) {
          return ProductPage(
            product: state.product,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      })),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('');
  }
}
