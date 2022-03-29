import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/products_bloc/products_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({required this.product, Key? key}) : super(key: key);
  final List product;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    var count = '';
    return Scaffold(
      body: BlocListener<ProductsBloc, ProductsState>(listener:
          (context, ProductsState state) {
        if (state is ProductFinded) {
          Navigator.pushNamed(context, '/product');
        }
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
        return SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                    child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Text(
                        widget.product.single['name'],
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                      Text(
                        widget.product.single['count'].toString(),
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                      widget.product.single['price'] != null
                          ? Text(
                              widget.product.single['price'],
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            )
                          : Text(
                              '0',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                      TextField(
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: "Введите количество",
                        ),
                        onChanged: (number) {
                          count = number;
                        },
                      ),
                      widget.product.single['img_url'] != null
                          ? Image.network(widget.product.single['img_url'])
                          : const FlutterLogo(
                              size: 72,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<ProductsBloc>(context).add(
                                  ReduceCountProduct(
                                      barcode: widget.product.single['barcode'],
                                      reduseBy: count));
                            },
                            child: const Text('Продать'),
                          ),
                          TextButton(
                              onPressed: () {
                                BlocProvider.of<ProductsBloc>(context).add(
                                    AddCountProduct(
                                        barcode:
                                            widget.product.single['barcode'],
                                        reduseBy: count));
                              },
                              child: const Text('Добавить')),
                          TextButton(
                              onPressed: () {}, child: const Text('Изменить')),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Назад'),
                      ),
                    ],
                  ),
                ))));
      })),
    );
  }
}
