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
      home: ScrollControllerTestRoute(),
    );
  }
}

class ScrollControllerTestRoute extends StatefulWidget {
  const ScrollControllerTestRoute({Key? key}) : super(key: key);

  @override
  _ScrollControllerTestRouteState createState() => _ScrollControllerTestRouteState();
}

class _ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {

  ScrollController _scrollController = ScrollController();

  // 是否展示回到顶部按钮
  bool showToTopBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.offset);
      if (_scrollController.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('滚动监听'),),
      body: Scrollbar(
        child: ListView.builder(itemBuilder: (context, index){
          return ListTile(title: Text('$index'),);
        }, itemCount: 100,itemExtent: 50, controller: _scrollController,),
      ),
      floatingActionButton: !showToTopBtn ? null : FloatingActionButton(onPressed: (){
        _scrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
      }, child: Icon(Icons.arrow_upward),),
    );
  }
}
