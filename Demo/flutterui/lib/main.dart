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
      home: AnimatedListRoute(),
    );
  }
}

class AnimatedListRoute extends StatefulWidget {
  const AnimatedListRoute({Key? key}) : super(key: key);

  @override
  _AnimatedListRouteState createState() => _AnimatedListRouteState();
}

class _AnimatedListRouteState extends State<AnimatedListRoute> {

  var data = <String>[];

  int counter = 5;

  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    for(var i = 0; i < counter; i++) {
      data.add('${i+1}');
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('animate'),),
      body: Stack(
        children: [
          AnimatedList(itemBuilder: (BuildContext context, int index, Animation<double> animation){
            return FadeTransition(opacity: animation, child: buildItem(context, index),);
          }, key: globalKey, initialItemCount: data.length,),
          buildAddBtn(),
        ],
      ),
    );
  }

  Widget buildAddBtn() {
    return Positioned(child: FloatingActionButton(child: Icon(Icons.add), onPressed: () {
      data.add('${++counter}');
      globalKey.currentState!.insertItem(data.length - 1);
      print("添加 ${counter}");
    },), bottom: 30, left: 0, right: 0,);
  }

  Widget buildItem(context, index) {
    String char = data[index];
    return ListTile(
      key: ValueKey(char),
      title: Text(char),
      trailing: IconButton(icon: Icon(Icons.delete), onPressed: () => onDelete(context, index),),
    );
  }

  void onDelete(context, index) {
      setState(() {
        globalKey.currentState!.removeItem(index, (context, animation) {
          var item = buildItem(context, index);
          print('删除 ${data[index]}');
          data.removeAt(index);
          return FadeTransition(opacity: CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
            child: SizeTransition(sizeFactor: animation,axisAlignment: 0.0,child: item,),);
        }, duration: Duration(milliseconds: 200));
      });
  }
}

