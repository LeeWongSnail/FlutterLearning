import 'package:flutter/material.dart';
import 'custom_tabbar/custom_tabbar.dart';
import 'stateful_Tabbar/each_view.dart';
import 'router_animation/RouterPages.dart';
import 'blur_effect/blur_widget.dart';
import 'widget_learning/container_demo.dart';

void main() => runApp(BlurApp());

class BlurApp extends StatelessWidget {
  const BlurApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blur Effect',
      // 自定义主题样本
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      home: Scaffold(
        body: ContainerDemo(),
      ),
    );
  }
}
