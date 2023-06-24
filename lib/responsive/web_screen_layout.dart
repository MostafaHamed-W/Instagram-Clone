import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/provider.dart';
import 'package:instagram_clone/utilities/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/model/user.dart' as model;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utilities/colors.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void onNavigationTappped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

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
              onPressed: () => onNavigationTappped(0),
              icon: FaIcon(
                Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
            ),
            IconButton(
              onPressed: () => onNavigationTappped(1),
              icon: FaIcon(
                Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor,
              ),
            ),
            IconButton(
              onPressed: () => onNavigationTappped(2),
              icon: FaIcon(
                Icons.add_circle,
                color: _page == 2 ? primaryColor : secondaryColor,
              ),
            ),
            IconButton(
              onPressed: () => onNavigationTappped(3),
              icon: FaIcon(
                FontAwesomeIcons.heart,
                color: _page == 3 ? primaryColor : secondaryColor,
              ),
            ),
            IconButton(
              onPressed: () => onNavigationTappped(4),
              icon: FaIcon(
                Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.facebookMessenger),
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (value) => onPageChanged,
          children: homeScreenItems,
        ));
  }
}
