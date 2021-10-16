import 'package:flutter/material.dart';
import 'bottom_navigation_widget.dart';

void main() => runApp(new BilibiliLearning());

class BilibiliLearning extends StatelessWidget {
  const BilibiliLearning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bilibili Learning',
      theme: ThemeData.light(),
      home: BottomNavigationWidget(),
    );
  }
}
