import 'package:flutter/material.dart';
import 'custom_tabbar/custom_tabbar.dart';

void main() => runApp(CustomTabbar());

class CustomTabbar extends StatelessWidget {
  const CustomTabbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Tabbar',
      // 自定义主题样本
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      home: CustomTabbarPage(),
    );
  }
}
