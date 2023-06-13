import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utilities/colors.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    );
  }
}




// Container(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 16,
//                 backgroundImage: NetworkImage(widget.snap['profImg']),
//               ),
//               Text(
//                 DateFormat.Hm().format(widget.snap['datePublished'].toDate()),
//                 style: const TextStyle(color: secondaryColor),
//               ),
//             ],
//           )
//         ],
//       ),
//     );