import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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
      home: TransformPage(),
    );
  }
}

class TransformPage extends StatelessWidget {
  const TransformPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transform'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 100, left: 100)),
          Container(
            color: Colors.black,
            child: Transform(
              alignment: Alignment.bottomLeft,
              transform: Matrix4.skewY(0.3),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.deepOrange,
                child: Text('Hello World'),
              ),
            ),
          ),
          // 平移
          Padding(padding: EdgeInsets.only(top: 50)),
          DecoratedBox(decoration: BoxDecoration(color: Colors.red), child: Transform.translate(offset: Offset(-20.0, -5.0), child: Text('Hello World'),),),
          Padding(padding: EdgeInsets.only(top: 50)),
          // 旋转
          DecoratedBox(decoration: BoxDecoration(color: Colors.red), child: Transform.rotate(angle: math.pi/2, child: Text('Hello World'),),),
          Padding(padding: EdgeInsets.only(top: 50)),
          // 缩放
          DecoratedBox(decoration: BoxDecoration(color: Colors.red), child: Transform.scale(scale: 1.5, child: Text('Hello World'),),),
          Padding(padding: EdgeInsets.only(top: 50)),
          RotatedBox(quarterTurns: 1, child: Text('Hello World'),),
          Padding(padding: EdgeInsets.only(top: 50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                  decoration:BoxDecoration(color: Colors.red),
                  child: Transform.scale(scale: 1.5,
                      child: Text("Hello world")
                  )
              ),
              Text("你好", style: TextStyle(color: Colors.green, fontSize: 18.0),)
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(decoration: BoxDecoration(
                color: Colors.red
              ), child: RotatedBox(quarterTurns: 1,child: Text('Hello World'),),),
              Text('你好，世界',style: TextStyle(color: Colors.green, fontSize: 18),),
            ],
          ),
        ],
      ),
    );
  }
}




