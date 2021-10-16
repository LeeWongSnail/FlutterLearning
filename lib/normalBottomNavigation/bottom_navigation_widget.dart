import 'package:flutter/material.dart';
import 'Pages/home.dart';
import 'Pages/email.dart';
import 'Pages/Pages.dart';
import 'Pages/airplay.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  final _BottomNaviagtionColor = Colors.blue;

  // 当前的索引
  int _currentIndex = 0;
  List<Widget> _tabs =  <Widget>[];

  @override initState() {
    _tabs
    ..add(HomePage())..add(EmailPage())..add(PagesPage())..add(AirPlayPage());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(

      //body 中间部分元素
      body: _tabs[_currentIndex],

      // 底部tab
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: _BottomNaviagtionColor,
        selectedItemColor: _BottomNaviagtionColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _BottomNaviagtionColor,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email, color: _BottomNaviagtionColor,),
            label: 'Email',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pages, color: _BottomNaviagtionColor,),
            label: 'Pages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplay, color: _BottomNaviagtionColor,),
            label: 'AirPlay',
          )
        ],
        // 哪一个展示高亮
        currentIndex: _currentIndex,
        // 点击事件
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

    );
  }
}

