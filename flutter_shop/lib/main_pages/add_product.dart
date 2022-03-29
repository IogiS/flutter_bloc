import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/products_bloc/products_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

Map product = {};

class _AddProductPageState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProductsBloc, ProductsState>(
          listener: (context, ProductsState state) {
        if (state is ProductAddSuccessfully) {
          const snackBar = SnackBar(
            content: Text('Успешно'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pop();
        }
        if (state is ProductAddFailed) {
          const snackBar = SnackBar(
            content: Text('Something went wrong'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }, child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Отсканируйте код",
                    ),
                    onChanged: (barcode) {
                      product['barcode'] = barcode;
                    },
                  ),
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Введите название товара",
                    ),
                    onChanged: (name) {
                      product['name'] = name;
                    },
                  ),
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Введите количество добавляемого товара",
                    ),
                    onChanged: (count) {
                      product['count'] = count;
                    },
                  ),
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Введите ссылку на фото",
                    ),
                    onChanged: (url) {
                      product['img_url'] = url;
                    },
                  ),
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Введите цену",
                    ),
                    onChanged: (price) {
                      product['price'] = price;
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<ProductsBloc>(context).add(AddProduct(
                            barcode: product['barcode'],
                            name: product['name'],
                            url_img: product['img_url'],
                            count: product['count'],
                            price: product['price']));
                      },
                      child: const Text('Добавить')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Назад')),
                ],
              ));
        },
      )),
    );
  }

  Widget textField(String textField) {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: "Введите $textField",
      ),
      onChanged: (field) {
        product[textField] = field;
      },
    );
  }
}
