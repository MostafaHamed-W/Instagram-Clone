import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/provider.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const webScreenSize = 600;
const homeScreenItems = [
  FeedScreen(),
  Center(child: Text("Search")),
  AddPostScreen(),
  Center(child: Text("Favourite")),
  ProfileScreen(),
];

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    bool isliked = false;
    bool isBookmarked = false;

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16).copyWith(right: 0),
            child: Row(
              children: [
                // Header Section
                //user profile pic
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    snap['profImg'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snap['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Tanta")
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ]
                                  .map(
                                    (e) => InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Text(e),
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ),
                      );
                    },
                    icon: const Icon(Icons.more_horiz))
              ],
            ),
          ),
          // Header Section
          // post image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.37,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),

          // Like and comment and share section
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: isliked == true
                    ? const FaIcon(FontAwesomeIcons.solidHeart)
                    : const FaIcon(FontAwesomeIcons.heart),
              ),
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.comment,
                ),
              ),
              Transform.rotate(
                angle: -0.8,
                child: IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    Icons.send,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      isBookmarked == true
                          ? FontAwesomeIcons.solidBookmark
                          : FontAwesomeIcons.bookmark,
                    ),
                  ),
                ),
              ),
            ],
          ),
          //Descrition and number of likes
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w900),
                  child: Text(
                    "${snap["likes"].length} likes",
                    // "1,250 likes",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: primaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: snap['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const TextSpan(text: "  "),
                        TextSpan(
                          text: snap['description'],
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: const Text(
                      "View all 200 comments",
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "07/05/1998",
                    // "${snap['datePublished']}",
                    style: const TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
