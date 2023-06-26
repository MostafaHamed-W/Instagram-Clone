import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/utilities/global_variables.dart';

import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:
          width > webScreenSize ? mobileBackgroundColor : mobileBackgroundColor, // note this
      appBar: width > webScreenSize
          ? null
          : AppBar(
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('datePublished', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width > webScreenSize ? width * 0.25 : 0,
                    vertical: width > webScreenSize ? 10 : 0,
                  ),
                  child: PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              );
            }
          }),
    );
  }
}
