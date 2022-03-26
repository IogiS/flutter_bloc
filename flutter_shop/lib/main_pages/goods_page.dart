import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoodsPage extends StatefulWidget {
  const GoodsPage({Key? key}) : super(key: key);

  @override
  State<GoodsPage> createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  FocusScopeNode focusScopeNode = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  autofocus: true,
                  focusNode: focusNode1,
                  decoration: const InputDecoration(
                    labelText: "Введите 1",
                  ),
                ),
                TextField(
                  focusNode: focusNode2,
                  decoration: InputDecoration(
                    labelText: "Введите 2",
                  ),
                ),
                TextField(
                  focusNode: focusNode3,
                  decoration: InputDecoration(
                    labelText: "Введите 3",
                  ),
                ),
              ],
            )));
  }
}
