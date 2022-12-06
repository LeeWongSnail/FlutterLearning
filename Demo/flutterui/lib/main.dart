import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
      home: const PaddingTestRoute(),
    );
  }
}

class PaddingTestRoute extends StatelessWidget {
  const PaddingTestRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.only(left: 20), child: Text('EdgeInsets.only(left: 20)', style: TextStyle(fontSize: 14),),),
          Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Text('EdgeInsets.symmetric(vertical: 10)', style: TextStyle(fontSize: 14)),),
          Padding(padding: EdgeInsets.fromLTRB(150, 0, 20, 0),child: Text('EdgeInsets.fromLTRB(20, 0, 20, 0)', style: TextStyle(fontSize: 14)),)
        ],
      ),
    );
  }
}


