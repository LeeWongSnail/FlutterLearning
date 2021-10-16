import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(FlutterApp());

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.book_solid), label: 'Articles'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.eye_solid), label: 'Views'),
      ],
    ), tabBuilder: (context, i) {
      return CupertinoTabView(
        builder: (context) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: (i == 0)? Text('Article') : Text('Views'),
            ),
            child: Center(
              child: CupertinoButton(
                child: Text('this is tab $i', style: CupertinoTheme.of(context).textTheme.actionTextStyle.copyWith(fontSize: 32),),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) {
                      return DetailScreen(i == 0? 'Article':'Views');
                    }),
                  );
                },
              ),
            ),
          );
        },
      );
    });
  }
}

class DetailScreen extends StatefulWidget {
  // 如果有自定义方法 默认方法需要删除
  // const DetailScreen({Key? key}) : super(key: key);
  const DetailScreen(this.topic);
  final String topic;
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Detail'),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(child: Text('Launch Action sheet'), onPressed: () {
                showCupertinoModalPopup(context: context, builder: (context) {
                  return CupertinoActionSheet(
                    title: Text('Some Choice'),
                    actions: [
                      CupertinoActionSheetAction(onPressed: (){
                        Navigator.pop(context,1);
                      }, child: Text('child 1'), isDefaultAction: true,),
                      CupertinoActionSheetAction(onPressed: (){
                        Navigator.pop(context,2);
                      }, child: Text('child 2')),
                      CupertinoActionSheetAction(onPressed: (){
                        Navigator.pop(context,3);
                      }, child: Text('child 3')),
                    ],
                  );
                });
              }),
            ],
          ),
        ),

      ),
    );
  }
}
