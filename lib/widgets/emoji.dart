import 'package:flutter/cupertino.dart';

class Emoji extends StatelessWidget {
  final String emoji;
  final double fontSize;

  const Emoji({Key? key, required this.emoji, this.fontSize = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      emoji,
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }
}
