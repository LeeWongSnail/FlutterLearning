import 'package:flutter/material.dart';
import 'custom_tabbar/custom_tabbar.dart';
import 'stateful_Tabbar/each_view.dart';
import 'router_animation/RouterPages.dart';

void main() => runApp(CustomTabbar());

class CustomTabbar extends StatelessWidget {
  const CustomTabbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Router Animation',
      // 自定义主题样本
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      home: RouterPages(),
    );
  }
}
