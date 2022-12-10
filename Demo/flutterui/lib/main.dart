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
      home: InfiniteListView(),
    );
  }
}

class InfiniteListView extends StatefulWidget {
  const InfiniteListView({Key? key}) : super(key: key);

  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  // 标记是否到达了尾部
  static const loadingTag = "##loading##";
  // 要展示的文本
  var _words = <String>[loadingTag];

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _retrieveData();
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((value) => {
      setState(() {
        _words.insertAll(_words.length - 1, generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('InfiniteListViewState'),),
      body: ListView.separated(itemBuilder: (BuildContext context, int index) {
        if (_words[index] == loadingTag) {
          // 如果到了最后一个
          if (_words.length < 100) {
            // 继续加载数据
            _retrieveData();
            return Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2,),
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Text('没有更多了', style: TextStyle(color: Colors.grey),),
            );
          }
        }
        return ListTile(title: Text(_words[index]),);
      }, separatorBuilder: (BuildContext context, int index) => Divider(height: .0,), itemCount: _words.length),
    );
  }
}



class FixHeightListViewRoute extends StatelessWidget {
  const FixHeightListViewRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FixHeightListViewRoute'),),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return LayoutLogPrint(child: ListTile(title: Text('1111'),), tag: index,);
      },  itemExtent: 30),
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

class ListViewSeparateRoute extends StatelessWidget {
  const ListViewSeparateRoute({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(color: Colors.blue,);
    Widget divider2 = Divider(color: Colors.green,);
    return Scaffold(appBar: AppBar(title: Text('ListViewSpearate'),),
      body: ListView.separated(itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text('$index'),);
      }, separatorBuilder: (BuildContext context, int index){
        return index % 2 == 0 ? divider1 : divider2;
      }, itemCount: 100),
    );
  }
}


class ListViewRouter extends StatelessWidget {
  const ListViewRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List View'),
      ),
      backgroundColor: Colors.yellow,
      body: ListView.builder(
          itemCount: 100,
          itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("$index"));
          }
      ),
    );;
  }
}


// class SingleChildScrollViewRoute extends StatelessWidget {
//   const SingleChildScrollViewRoute({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     String str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ListView'),
//         backgroundColor: Colors.yellow,
//       ),
//       backgroundColor: Colors.yellow,
//       body: ListView(
//         //是否根据子组件的总长度来设置ListView的长度
//         shrinkWrap: true,
//         padding: EdgeInsets.all(20),
//         children: [
//           Text('I hear your voice on the line' ,style: TextStyle(fontSize: 16),),
//           Text('but it doesn’t stop the pain.',style: TextStyle(fontSize: 16)),
//           Text('If I see you next to never',style: TextStyle(fontSize: 16)),
//           Text('how can we say forever？',style: TextStyle(fontSize: 16))
//         ],
//       ),
//     );
//   }
// }
