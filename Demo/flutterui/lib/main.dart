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
      home: TabViewRoute2(),
    );
  }
}


class TabViewRoute2 extends StatelessWidget {
  const TabViewRoute2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List tabs = ['新闻','历史','图片'];
    return DefaultTabController(length: tabs.length, child: Scaffold(
      appBar: AppBar(title: Text('TabBarView2'),
        bottom: TabBar(tabs: tabs.map((e) => Tab(text: e,)).toList(),),
      ),
      body: TabBarView(
        children: tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 5,),
          );
        }).toList(),
      ),
    ));
  }
}


class TabViewRoute extends StatefulWidget {
  const TabViewRoute({Key? key}) : super(key: key);

  @override
  _TabViewRouteState createState() => _TabViewRouteState();
}

class _TabViewRouteState extends State<TabViewRoute> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  List tabs = ['新闻','历史','图片'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TabBarView'),
        bottom: TabBar(controller: _tabController, tabs: tabs.map((e) => Tab(text: e,)).toList(),),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 5,),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
