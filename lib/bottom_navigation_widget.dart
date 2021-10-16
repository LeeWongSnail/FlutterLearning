import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  final _BottomNaviagtionColor = Colors.blue;

  Widget build(BuildContext context) {
    return Scaffold(
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
      ),

    );
  }
}

