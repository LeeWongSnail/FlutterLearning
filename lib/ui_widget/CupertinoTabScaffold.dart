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
                      return DetailScreen(i == 0 ? 'Article' : 'Views');
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


class DetailScreen extends StatelessWidget {
  const DetailScreen(this.topic);
  final String topic;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Detail'),
      ),
      child: Center(
        child: Text('Detail for $topic', style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,),
      ),
    );
  }
}



// 搭建整体UI框架
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoTabScaffold(tabBar: CupertinoTabBar(
//       items: [
//         BottomNavigationBarItem(icon: Icon(CupertinoIcons.book_solid), label: 'Articles'),
//         BottomNavigationBarItem(icon: Icon(CupertinoIcons.eye_solid), label: 'Views'),
//       ],
//     ), tabBuilder: (context, i) {
//       return Center(
//         child: Text('Hello Flutter $i！'),
//       );
//     });
//   }
// }