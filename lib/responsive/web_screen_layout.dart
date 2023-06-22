import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/model/user.dart' as model;

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: Center(
        child: Text("my name is ${user.fullname} iam ${user.bio}"),
      ),
    );
  }
}
