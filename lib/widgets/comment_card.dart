import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import '../utilities/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(widget.snap['profilePic']),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: user.username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: '  ',
                        ),
                        TextSpan(
                          text: DateFormat.E()
                              .format(widget.snap['datePublished'].toDate())
                              .toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      widget.snap['commentText'],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: widget.snap['likes'].length != 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: secondaryColor,
                                fontSize: 13,
                              ),
                              children: [
                                TextSpan(text: '${widget.snap['likes'].length}'),
                                const TextSpan(text: ' '),
                                const TextSpan(text: 'likes')
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Reply',
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const Text(
                        'See translition',
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: LikeAnimation(
              smallLike: true,
              isAnimating: widget.snap['likes'].contains(user.uid),
              child: GestureDetector(
                onTap: () async {
                  FirestoreMethods().likeComment(
                    postId: widget.snap['postId'],
                    uid: user.uid,
                    commentId: widget.snap['commentId'],
                    likes: widget.snap['likes'],
                  );
                },
                child: widget.snap['likes'].contains(user.uid)
                    ? const FaIcon(
                        FontAwesomeIcons.solidHeart,
                        size: 14,
                        color: Colors.red,
                      )
                    : const FaIcon(
                        FontAwesomeIcons.heart,
                        size: 14,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
