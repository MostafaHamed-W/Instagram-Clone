import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/comment_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../widgets/emoji.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    InputDecoration commentTextFieldDecoration() {
      return InputDecoration(
        suffix: TextButton(
          child: const Text("Post"),
          onPressed: () async {
            await FirestoreMethods().commentPost(
                commentText: _commentEditingController.text,
                postId: widget.snap['postId'],
                uid: widget.snap['uid'],
                username: user.username,
                profilePic: user.photoUrl);
            setState(() {
              _commentEditingController.text = '';
            });
          },
        ),
        hintText: "Add a comment for ${widget.snap['username']}",
        hintStyle: TextStyle(color: secondaryColor.withOpacity(0.6)),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: secondaryColor.withOpacity(0.6), width: 0.8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: secondaryColor.withOpacity(0.6), width: 0.8),
        ),
        contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
      );
    }

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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      addEmoji('❤️');
                    },
                    child: const Emoji(emoji: " ❤️", fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      addEmoji('🙌');
                    },
                    child: const Emoji(emoji: " 🙌", fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      addEmoji('😂');
                    },
                    child: const Emoji(emoji: "😂", fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      addEmoji('🔥');
                    },
                    child: const Emoji(emoji: " 🔥", fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      addEmoji('👏');
                    },
                    child: const Emoji(emoji: " 👏 ", fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      addEmoji('😢');
                    },
                    child: const Emoji(emoji: " 😢", fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      addEmoji('😍');
                    },
                    child: const Emoji(emoji: " 😍", fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      addEmoji('😮');
                    },
                    child: const Emoji(emoji: " 😮", fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              height: kToolbarHeight,
              width: double.infinity,
              // color: Colors.white,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: secondaryColor.withOpacity(0.8), width: 1),
                    ),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(user.photoUrl),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    child: TextFormField(
                      controller: _commentEditingController,
                      decoration: commentTextFieldDecoration(),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .orderBy('datePublished', descending: false) //  order of comments
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => CommentCard(
                snap: snapshot.data!.docs[index],
              ),
            );
          }
        },
      ),
    );
  }

  void addEmoji(String emoji) {
    // Insert emoji into the TextFieldForm
    _commentEditingController.text += emoji;
    _commentEditingController.text += "  ";
    // to prevent select all that pop up
    _commentEditingController.selection =
        TextSelection.collapsed(offset: _commentEditingController.text.length);
    // Move the cursor to the end of the text
    _commentEditingController.selection = TextSelection.fromPosition(
      TextPosition(offset: _commentEditingController.text.length),
    );
  }
}
