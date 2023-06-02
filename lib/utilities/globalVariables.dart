import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/providers/provider.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:provider/provider.dart';

const webScreenSize = 600;
const homeScreenItems = [
  Center(child: Text("Home")),
  Center(child: Text("Search")),
  AddPostScreen(),
  Center(child: Text("Favourite")),
  ProfileScreen(),
];
