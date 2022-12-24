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
      home: KeepAliveWrapperListView(),
    );
  }
}

class KeepAliveWrapperListView extends StatefulWidget {
  const KeepAliveWrapperListView({Key? key}) : super(key: key);

  @override
  _KeepAliveWrapperListViewState createState() => _KeepAliveWrapperListViewState();
}

class _KeepAliveWrapperListViewState extends State<KeepAliveWrapperListView> {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for(int i = 0; i < 6; i++) {
      children.add(KeepAliveWrapper(child: Page(text: '${i}',)));
    }
    return Scaffold(appBar: AppBar(title: Text('KeepAlive'),),
      body: PageView(children: children,),
    );
  }
}

// Tab 页面
class Page extends StatefulWidget {
  const Page({
    Key? key,
    required this.text
  }) : super(key: key);

  final String text;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    print("build ${widget.text}");
    return Center(child: Text("${widget.text}", textScaleFactor: 5));
  }
}

class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({Key? key, this.keepAlive = true, required this.child}) : super(key: key);

  final bool keepAlive;
  final Widget child;

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    // TODO: implement didUpdateWidget
    if(oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => widget.keepAlive;
}


class KeepAliveTest extends StatelessWidget {
  const KeepAliveTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (_, index){
      // 为 true 后会缓存所有的列表项，列表项将不会销毁。
      // 为 false 时，列表项滑出预加载区域后将会别销毁。
      // 使用时一定要注意是否必要，因为对所有列表项都缓存的会导致更多的内存消耗
      return KeepAliveWrapper(child: ListItem(index: index,), keepAlive: true,);
    });
  }
}

class ListItem extends StatefulWidget {
  const ListItem({Key? key, required this.index}) : super(key: key);

  final int index;
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text('${widget.index}'),);
  }

  @override
  void dispose() {
    print('dispose ${widget.index}');
    // TODO: implement dispose
    super.dispose();
  }
}


