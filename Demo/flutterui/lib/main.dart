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
      home: InfiniteGridView(),
    );
  }
}


class SliverGridDelegateCrossAxisExtent extends StatefulWidget {
  const SliverGridDelegateCrossAxisExtent({Key? key}) : super(key: key);

  @override
  _SliverGridDelegateCrossAxisExtentState createState() => _SliverGridDelegateCrossAxisExtentState();
}

class _SliverGridDelegateCrossAxisExtentState extends State<SliverGridDelegateCrossAxisExtent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('GridView'),),
      body: GridView.extent(
        maxCrossAxisExtent: 120.0,
        childAspectRatio: 2.0,
        children: <Widget>[
          Icon(Icons.ac_unit),
          Icon(Icons.airport_shuttle),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast),
        ],
      ),);
  }
}


class InfiniteGridView extends StatefulWidget {
  const InfiniteGridView({Key? key}) : super(key: key);

  @override
  _InfiniteGridViewState createState() => _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {

  List<IconData> _icons = []; // 保存icon数据

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveIcons();
  }

  void _retrieveIcons() {
   Future.delayed(Duration(milliseconds: 200)).then((e){
     setState(() {
       _icons.addAll([
         Icons.ac_unit,
         Icons.airport_shuttle,
         Icons.all_inclusive,
         Icons.beach_access,
         Icons.cake,
         Icons.free_breakfast,
       ]);
     });
   }) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('GridView'),),
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 每行三列
        childAspectRatio: 1.0 // 宽高比
      ), itemBuilder: (context, index) {
        if(index == _icons.length - 1 && _icons.length < 200) {
          _retrieveIcons();
        }
        return Icon(_icons[index]);
      }, itemCount: _icons.length,),
    );
  }
}


class GrideViewRoute extends StatefulWidget {
  const GrideViewRoute({Key? key}) : super(key: key);

  @override
  _GrideViewRouteState createState() => _GrideViewRouteState();
}

class _GrideViewRouteState extends State<GrideViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('GridView'),),
        body: GridView(children: [
          Icon(Icons.ac_unit),
          Icon(Icons.airport_shuttle),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast,color: Colors.red,)
        ],gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 横轴展示的widget个数
          mainAxisSpacing: 20, //主轴方向的间距。
          childAspectRatio: 1.0, // 子元素在横轴长度和主轴长度的比例。
          crossAxisSpacing: 5, // 横轴方向子元素的间距。
        ),)
      );
  }
}

class GridViewCountRoute extends StatefulWidget {
  const GridViewCountRoute({Key? key}) : super(key: key);

  @override
  _GridViewCountRouteState createState() => _GridViewCountRouteState();
}

class _GridViewCountRouteState extends State<GridViewCountRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GridViewCount'),),
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        children: <Widget>[
          Icon(Icons.ac_unit),
          Icon(Icons.airport_shuttle),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast),
        ],
      ),
    );
  }
}

