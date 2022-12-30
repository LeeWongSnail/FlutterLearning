import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

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
      home: NestedScrollViewRoute(),
    );
  }
}


class NestedScrollViewRoute extends StatelessWidget {
  const NestedScrollViewRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text('NestedScrollView'),
              pinned: true,
              forceElevated: innerBoxIsScrolled,
            ),
            buildSliverList()
          ];
        },
        body: ListView.builder(itemBuilder: (BuildContext context, int index){
          return SizedBox(
            height: 50,
            child: Center(child: Text('Item $index'),),
          );
        }, padding:  EdgeInsets.all(8), physics: ClampingScrollPhysics(), itemCount: 30,),
      ),
    );
  }
  Widget buildSliverList() {
    var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
      return ListTile(title: Text('$index'),);
    }, childCount: 5), itemExtent: 56);
    return listView;
  }
}

class NestedTabBarView extends StatelessWidget {
  const NestedTabBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tabs = ['猜你喜欢','今日特价', '发现更多'];
    return DefaultTabController(length: _tabs.length, child: Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: Text('商城'),
                floating: true,
                snap: true, // 是否固定在顶部
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  tabs: _tabs.map((e) => Tab(text: e,)).toList(),
                ),
              ),),
          ];
        },
        body: TabBarView(
          children: _tabs.map((e) {
            return Builder(builder: (BuildContext context) {
              return CustomScrollView(
                key: PageStorageKey(e),
                slivers: [
                  SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                  SliverPadding(padding: EdgeInsets.all(8),sliver: buildSliverList(),),
                ],
              );
            });
          }).toList(),
        ),
      ),
    ));
  }

  Widget buildSliverList() {
    var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
      return ListTile(title: Text('$index'),);
    }, childCount: 100), itemExtent: 56);
    return listView;
  }
}


class SnapAppBar2 extends StatefulWidget {
  const SnapAppBar2({Key? key}) : super(key: key);

  @override
  _SnapAppBar2State createState() => _SnapAppBar2State();
}

class _SnapAppBar2State extends State<SnapAppBar2> {

  late SliverOverlapAbsorberHandle handle;

  void onOverlapChanged() {
    print(handle.layoutExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          handle = NestedScrollView.sliverOverlapAbsorberHandleFor(context);
          handle.removeListener(onOverlapChanged);
          handle.addListener(onOverlapChanged);

          return [
            SliverOverlapAbsorber(handle: handle, sliver: SliverAppBar(
              floating: true,
              snap: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "/Users/leewong/Documents/Code/Flutter/Project/FlutterLearning/Demo/flutterui/images/icon.webp",
                  fit: BoxFit.cover,
                ),
              ),
              forceElevated: innerBoxIsScrolled,
            ),)
          ];
        },
        body: LayoutBuilder(builder: (BuildContext context, cons) {
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(handle: handle),
              buildSliverList()
            ],
          );
        },),
      ),
    );
  }

  Widget buildSliverList() {
    var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
      return ListTile(title: Text('$index'),);
    }, childCount: 100), itemExtent: 56);
    return listView;
  }
}




class SnapAppBar extends StatelessWidget {
  const SnapAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                floating: true,
                snap: true,
                expandedHeight: 200,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "/Users/leewong/Documents/Code/Flutter/Project/FlutterLearning/Demo/flutterui/images/icon.webp",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

          ];
        },
        body: Builder(builder: (BuildContext context) {
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              buildSliverList(),
            ],
          );
        },),
      ),
    );
  }

  Widget buildSliverList() {
    var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
      return ListTile(title: Text('$index'),);
    }, childCount: 100), itemExtent: 56);
    return listView;
  }
}
//
//
// class SnapAppBar extends StatelessWidget {
//   const SnapAppBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return [
//             SliverAppBar(
//               floating: true,
//               snap: true,
//               expandedHeight: 200,
//               forceElevated: innerBoxIsScrolled,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Image.asset("/Users/LeeWong/StudioProjects/flutter_ui/images/sea.jpeg", fit: BoxFit.cover,),
//               ),
//             )
//           ];
//         },
//         body: Builder(builder: (BuildContext context) {
//           return CustomScrollView(
//             slivers: [
//               buildSliverList()
//             ],
//           );
//         },),
//       ),
//     );
//   }
//
//   Widget buildSliverList() {
//     var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
//       return ListTile(title: Text('$index'),);
//     }, childCount: 100), itemExtent: 56);
//     return listView;
//   }
// }
