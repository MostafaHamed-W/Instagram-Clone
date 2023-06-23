import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/model/user.dart' as model;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utilities/colors.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          'assets/instagram_clone.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.heart),
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.facebookMessenger),
          )
        ],
      ),
      body: Center(
        child: Text("my name is ${user.fullname} iam ${user.bio}"),
      ),
    );
  }
}
