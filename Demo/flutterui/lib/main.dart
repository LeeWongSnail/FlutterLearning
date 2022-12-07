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
          ClipOval(child: Container(
            width: 120,
            height: 120,
            color: Colors.red,
          ),),
          ClipOval(child: Container(
            width: 120,
            height: 80,
            color: Colors.red,
          ),),
          ClipRRect(borderRadius: BorderRadius.circular(20), child: Container(
            width: 120,
            height: 80,
            color: Colors.red,
          ),),
          ClipRect(child: Container(
            width: 120,
            height: 60,
            color: Colors.red,
            child: Text('Hello World', style: TextStyle(fontSize: 40),),
          ),),
          ClipPath.shape(shape: StadiumBorder(), child: Container(
            height: 150,
            width: 250,
            color: Colors.red,
            child: FlutterLogo(),
          )),
          ClipPath(clipper: _TrianglePath(),child: Container(
            width: 250,
            height: 150,
            color: Colors.red,
            child: FlutterLogo(),
          ),),
        ],
      ),
    );
  }
}

class _TrianglePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }


  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}



