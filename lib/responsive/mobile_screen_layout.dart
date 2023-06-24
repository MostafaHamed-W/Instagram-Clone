import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/model/user.dart' as model;
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late PageController pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return const SimpleDialog(
          title: Text("Create a post"),
          children: [
            SimpleDialogOption(),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onNavigationTappped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenItems,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _page == 0 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: _page == 1 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  color: _page == 2 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.circlePlay,
                  color: _page == 3 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor,
              ),
              backgroundColor: primaryColor,
            ),
          ],
          onTap: onNavigationTappped,
        ),
      ),
    );
  }
}
