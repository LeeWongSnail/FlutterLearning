import 'package:flutter/material.dart';

class RichTextDemo extends StatelessWidget {

  final TextStyle _textStyle = TextStyle(
    fontSize: 30,
    color: Colors.red,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400
  );


  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(text: TextSpan(
        text: 'Rich Text',
        style: _textStyle,
        children: [
          TextSpan(
            text: '.net',
            style: TextStyle(
              fontSize: 17.0, color: Colors.grey
            ),
          ),
        ],
      ), ),
    );
  }
}
