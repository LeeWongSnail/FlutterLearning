import 'package:flutter/cupertino.dart';

void main() => runApp(FlutterApp());

class FlutterApp extends StatelessWidget {
  // const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          navLargeTitleTextStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 80.0,
            color: CupertinoColors.systemRed
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}


class HomeScreen extends StatelessWidget {
  // const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child:  Text('Hello', style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle),
      ),
    );
  }
}



