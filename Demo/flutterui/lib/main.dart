import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

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
      home: MyHomePage('WillPopScope'),
    );
  }
}


class WillPopScopeTestRoute extends StatefulWidget {
  const WillPopScopeTestRoute({Key? key}) : super(key: key);

  @override
  _WillPopScopeTestRouteState createState() => _WillPopScopeTestRouteState();
}

class _WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {

  // 上次点击时间
  DateTime? _lastPressAt;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Container(alignment: Alignment.center, child: Text('连续点击退出'),), onWillPop: () async {
      if (_lastPressAt == null || DateTime.now().difference(_lastPressAt!) > Duration(seconds: 1)) {
        _lastPressAt = DateTime.now();
        return false;
      }
      return true;
    });
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    // 跳转到other 页面在该页面做返回按键点击的处理
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return OtherPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WillPopScope(
        // 回调函数，返回true 就pop 返回false 就不处理
        onWillPop: () async {
          var result = await showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                    title: const Text('再次点击就退出该页面'),
                    content: const Text('退出会返回到上一个页面'),
                    actions: [
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        child: const Text('确定'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        child: const Text('取消'),
                        onPressed: () => Navigator.of(context).pop(false),
                      )
                    ]);
              });
          return result;
        },

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                'jump to other page',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'jump to other page',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class OtherPage extends StatelessWidget {
  OtherPage({Key? key}) : super(key: key);
  DateTime? firstTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('hello,jack ma!'),
        ),
        body: WillPopScope(
          onWillPop: () async {
            var result = await showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                      title: const Text('再次点击就退出该页面'),
                      content: const Text('退出会返回到上一个页面'),
                      actions: [
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: const Text('确定'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text('取消'),
                          onPressed: () => Navigator.of(context).pop(false),
                        )
                      ]);
                });
            return result;
          },
          child: const Center(child: Text('I AM TOHER PAGE')),
        ));
  }
}


// class OtherPage extends StatelessWidget {
//   OtherPage({Key? key}) : super(key: key);
//   DateTime? firstTime;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('hello,jack ma!'),
//         ),
//         body: WillPopScope(
//           onWillPop: () async {
//             //如果时间是空的就把新的时间给firstTime
//             if (firstTime == null) {
//               firstTime = DateTime.now();
//             } else {
//               if (DateTime.now().difference(firstTime!) <
//                   const Duration(milliseconds: 600)) {
//                 return true;
//               } else {
//                 // 如果两次的间隔时间大于600毫秒的话，就重新赋值给firstTime
//                 firstTime = DateTime.now();
//               }
//             }
//
//             return false;
//           },
//           child: const Center(child: Text('I AM TOHER PAGE')),
//         ));
//   }
// }
