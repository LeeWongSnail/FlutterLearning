import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: NestedTabBarView(),
    );
  }
}

typedef SliverPersistentHeaderToBoxBuilder = Widget Function(BuildContext context, double maxExtent, bool fixed);

class SliverPersistentHeaderToBox extends StatelessWidget {

  const SliverPersistentHeaderToBox({Key? key, required Widget child,}) : builder = ((a, b, c) => child), super(key: key);

  SliverPersistentHeaderToBox.builder({
    Key? key,
    required this.builder,
   }) : super(key: key)

  final SliverPersistentHeaderToBoxBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _RenderSliverPersistentHeaderToBox extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    // TODO: implement performLayout
    if(child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    child!.layout(ExtraI





    )
  }
}