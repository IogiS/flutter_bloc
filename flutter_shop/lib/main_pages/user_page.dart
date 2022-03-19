import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/user_bloc/user_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<UserBloc, UserState>(
            listener: (context, UserState state) {},
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is UserLoaded) {
                  return SafeArea(
                    minimum: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: <Widget>[
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://p4.wallpaperbetter.com/wallpaper/905/929/199/aang-avatar-the-last-airbender-angry-monochrome-wallpaper-preview.jpg'),
                        ),
                        const Text(
                          "Shivansh Singh",
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Pacifico",
                          ),
                        ),
                        Text(
                          "Flutter Developer",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.blueGrey[200],
                              letterSpacing: 2.5,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Source Sans Pro"),
                        ),
                        const SizedBox(
                          height: 20,
                          width: 200,
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),

                        // we will be creating a new widget name info carrd

                        InfoCard(
                            text: BlocProvider.of<UserBloc>(context)
                                .user['phone'],
                            icon: Icons.phone,
                            onPressed: () async {}),
                        InfoCard(
                            text: BlocProvider.of<UserBloc>(context)
                                .user['website'],
                            icon: Icons.web,
                            onPressed: () async {}),
                        InfoCard(
                            text: BlocProvider.of<UserBloc>(context)
                                .user['address']['city'],
                            icon: Icons.location_city,
                            onPressed: () async {}),
                        InfoCard(
                            text: BlocProvider.of<UserBloc>(context)
                                .user['email'],
                            icon: Icons.email,
                            onPressed: () async {}),
                      ],
                    ),
                  );
                } else
                  return Container();
              },
            )));
  }
}

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  final Function onPressed;

  InfoCard({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.teal,
        ),
        title: Text(
          text,
          style: const TextStyle(
              color: Colors.teal, fontSize: 20, fontFamily: "Source Sans Pro"),
        ),
      ),
    );
  }
}
