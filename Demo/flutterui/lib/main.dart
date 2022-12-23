import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:english_words/english_words.dart';

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
      home: PagingView(),
    );
  }
}

class PagingView extends StatefulWidget {
  const PagingView({Key? key}) : super(key: key);

  @override
  _PagingViewState createState() => _PagingViewState();
}

class _PagingViewState extends State<PagingView> {
  @override
  Widget build(BuildContext context) {

    var children = <Widget>[];
    for(int i = 0; i < 6; i++) {
      children.add(Page(text: '${i}'));
    }

    return Scaffold(appBar: AppBar(title: Text('PageView'),),
      body: PageView(children: children,scrollDirection: Axis.vertical,allowImplicitScrolling: true,),
    );
  }
}



class Page extends StatefulWidget {
  const Page({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    print('build ${widget.text}');
    return Center(child: Text("${widget.text}", textScaleFactor: 5,),);
  }
}
