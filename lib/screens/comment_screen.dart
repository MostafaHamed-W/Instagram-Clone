import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/provider.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          "Comments",
          style: TextStyle(color: primaryColor, fontSize: 18),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              color: secondaryColor,
            ),
            Container(
              height: kToolbarHeight,
              width: double.infinity,
              // color: Colors.white,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(user.photoUrl),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: TextFormField(
                        decoration: const InputDecoration(border: OutlineInputBorder())),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.snap['profImg']),
                ),
                Text(
                  DateFormat.Hm().format(widget.snap['datePublished'].toDate()),
                  style: const TextStyle(color: secondaryColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
