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
          Text('data'*20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(children: [Text('xx'*30)]), //文本长度超出 Row 的最大宽度会溢出
          ),
          FittedBox(
            child: Row(children: [Text('xx'*30)]),
            // fit: BoxFit.scaleDown,
            // clipBehavior: Clip.none,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          // 两种不同的方式设置fit
          Container(
            width: 50,
            height: 50,
            color: Colors.red,
            child: FittedBox(fit: BoxFit.none, child: Container(width: 60,height: 70, color: Colors.blue,),),
          ),
          Text('Hello World'),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Container(
            width: 50,
            height: 50,
            color: Colors.red,
            child: FittedBox(fit: BoxFit.contain, child: Container(width: 60,height: 70, color: Colors.blue,),),
          ),
          Text('Hello World'),
          Center(
          child: Column(
            children:  [
              wRow(' 90000000000000000 '),
              FittedBox(child: wRow(' 90000000000000000 ')),
              wRow(' 800 '),
              FittedBox(child: wRow(' 800 ')),
            ]
                .map((e) => Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: e,
            ))
                .toList(),
          ),
        ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          wRow(' 90000000000000000 '),
          SingleLineFittedBox(child: wRow(' 90000000000000000 ')),
          wRow(' 800 '),
          SingleLineFittedBox(child: wRow(' 800 ')),
      ],
      ),
    );
  }

  // 直接使用Row
  Widget wRow(String text) {
    Widget child = Text(text);
    child = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [child, child, child],
    );
    return child;
  }
}

class SingleLineFittedBox extends StatelessWidget {
  const SingleLineFittedBox({Key? key,this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return FittedBox(
          child: ConstrainedBox(
            constraints: constraints.copyWith(
              //让 maxWidth 使用屏幕宽度
                minWidth: constraints.maxWidth,
              maxWidth: double.infinity,
            ),
            child: child,
          ),
        );
      },
    );
  }
}


