import 'package:flutter/material.dart';

class TextDemo extends StatelessWidget {

  final TextStyle _textStyle = TextStyle(
    fontSize: 30,
    color: Colors.red,
  );

  final String _author = '李白';
  final String _title = '将进酒';


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(' 《$_author》 -- $_title  君不见黄河之水天上来②，奔流到海不复回。君不见高堂明镜悲白发③，朝如青丝暮成雪④。人生得意须尽欢⑤，莫使金樽空对月⑥。天生我材必有用⑦，千金散尽还复来⑧。烹羊宰牛且为乐，会须一饮三百杯⑨。',
      style: _textStyle),
    );
  }
}
