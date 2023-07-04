import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

const webScreenSize = 500;
List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScrean(),
  const AddPostScreen(),
  const Text("Favourite"),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
