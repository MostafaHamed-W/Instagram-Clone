import 'package:flutter/material.dart';


class FollowBtton extends StatelessWidget {
  final Function()? function;
  final Color backgroungColor;
  final Color borderColor;
  final String buttonText;
  final Color textColor;
  const FollowBtton(
      {super.key,
      required this.function,
      required this.backgroungColor,
      required this.borderColor,
      required this.buttonText,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: backgroungColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: const BorderSide(color: Colors.transparent)),
        onPressed: function,
        child: Container(
          alignment: Alignment.center,
          child: Text(buttonText, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
