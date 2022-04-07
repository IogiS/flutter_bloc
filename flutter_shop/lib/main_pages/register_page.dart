import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool pressed = true;
  bool isChecked = false;
  List focused = List<bool>.generate(6, (counter) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(50),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "http://grandvincent-marion.fr/img-codePen/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: (() => setState(() {
                                pressed = true;
                              })),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: pressed
                                        ? BorderSide(
                                            width: 2,
                                            color: HexColor("#1161ee"))
                                        : const BorderSide(
                                            width: 2,
                                            color: Colors.transparent)),
                              ),
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(
                                  color: pressed ? Colors.white : Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ))),
                      const SizedBox(
                        width: 50,
                      ),
                      TextButton(
                          onPressed: (() => setState(() {
                                pressed = false;
                              })),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: !pressed
                                        ? BorderSide(
                                            width: 2,
                                            color: HexColor("#1161ee"))
                                        : const BorderSide(
                                            width: 2,
                                            color: Colors.transparent)),
                              ),
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                  color: !pressed ? Colors.white : Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ))),
                    ],
                  ),
                  pressed ? signIn() : signUp(),
                ]))));
  }

  Widget customCheckBoxListTile(String title) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.focused,
        MaterialState.selected,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05)),
      Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
      Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      )
    ]);
  }

  Widget signUp() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15)),
        customTextFormField('USERNAME', 2),
        customTextFormField('E-MAIL', 3),
        customTextFormField('PASSWORD', 4),
        customTextFormField('CONFIRM PASSWORD', 5),
        customCheckBoxListTile('I agree'),
        customTextButton('SIGN UP'),
      ],
    );
  }

  Widget signIn() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15)),
        customTextFormField('USERNAME', 0),
        customTextFormField('PASSWORD', 1),
        customCheckBoxListTile("Keep me signed in"),
        customTextButton('SIGN IN'),
        Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15)),
        const Divider(
          color: Colors.white12,
          thickness: 2,
        ),
        TextButton(
          onPressed: () {},
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.white;
              }
              return Colors.white12;
            }),
          ),
          child: const Text(
            'Forgot password?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }

  Widget customTextFormField(String title, int index) {
    return FocusScope(
        child: Focus(
            onFocusChange: (focus) {
              setState(() {
                focused[index] = focus;
              });
            },
            child: Column(children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )),
              Container(
                  height: 50,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      fillColor: Colors.white12,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: focused[index]
                        ? Border.all(color: Colors.white12)
                        : Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ))
            ])));
  }

  Widget customTextButton(String title) {
    return GestureDetector(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: Center(
              child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          )),
          padding: const EdgeInsets.only(left: 3, right: 3, top: 4, bottom: 4),
          decoration: BoxDecoration(
            color: HexColor("#1161ee"),
            borderRadius: BorderRadius.circular(30),
          )),
      onTap: () => {},
    );
  }
}
