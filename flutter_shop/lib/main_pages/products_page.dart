import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/products_bloc/products_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String barCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProductsBloc, ProductsState>(
          listener: (context, ProductsState state) {
        if (state is ProductNotFinded) {
          const snackBar = SnackBar(
            content: Text('Not Found 404'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }, child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return Center(child: FlutterLogo(size: 300));
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addProduct');
        },
      ),
    );
  }
}
