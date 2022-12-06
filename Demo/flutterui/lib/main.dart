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
      home: const LayoutBuilderRoute(),
    );
  }
}


class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({Key? key, required this.children}) : super(key: key);

  final List <Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 200) {
        // 最大的宽度小于200 则显示单列
        return Column(children: children, mainAxisSize: MainAxisSize.min,);
      } else {
        // 最大宽度大于200 则展示双列
        // 这里需要将数据拆分成一行两列的形式
        var _children = <Widget>[];
        for(var i = 0; i < children.length; i = i+2) {
          // 需要判断是否还存在下一个
          if (i+1 < children.length) {
            // 还有下一个
            _children.add(Row(
              children: [children[i], children[i+1]],
              mainAxisSize: MainAxisSize.min,
            ));
          } else {
            _children.add(children[i]);
          }
        }
        return Column(children: _children, mainAxisSize: MainAxisSize.min,);
      }
    });
  }
}


class LayoutBuilderRoute extends StatelessWidget {
  const LayoutBuilderRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _children = List.filled(6, Text('A'));
    // Column 在本市李忠在水平方向的最大宽度为屏幕的宽度
    return Column(
      children: [
        Container(width: 100, height: 100,),
        SizedBox(width: 190, child: ResponsiveColumn(children: _children,),),
        ResponsiveColumn(children: _children),
        LayoutLogPrint(child: Text('AA')), // flutter: Text("AA"): BoxConstraints(0.0<=w<=393.0, 0.0<=h<=Infinity)
      ],
    );
  }
}

class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint ({Key? key, this.tag, required this.child}) : super(key: key);

  final Widget child;
  final T? tag; // 指定的日志

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      assert(() {
        print('${tag ?? key ?? child}: $constraints');
        return true;
      }());
      return child;
    });
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
      body: Container(),
    );
  }
}

