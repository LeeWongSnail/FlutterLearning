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
      home: const ProgressRoute(),
    );
  }
}

class ProgressRoute extends StatefulWidget {
  const ProgressRoute({Key? key}) : super(key: key);

  @override
  _ProgressRouteState createState() => _ProgressRouteState();
}

class _ProgressRouteState extends State<ProgressRoute> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Box'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Flex(direction: Axis.horizontal,
              children: [
                Expanded(child: Container(
                  height: 30,
                  color: Colors.red,
                ),flex: 1,),
                Expanded(child: Container(
                  height: 30,
                  color: Colors.green,
                ),flex: 2,),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 100,
                child: Flex(direction: Axis.vertical,
                children: [
                  Expanded(child: Container(
                    height: 30,
                    color: Colors.red,
                  ), flex: 2,),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(child: Container(
                    height: 60,
                    color: Colors.yellow,
                  ), flex: 1,)
                ],
                ),
              ),
            ),
          ],
        ),
    ),
    );
  }
}
