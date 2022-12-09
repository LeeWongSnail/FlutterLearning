import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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
      home: ScaffoldRoute(),
    );
  }
}

class ScaffoldRoute extends StatefulWidget {
  const ScaffoldRoute({Key? key}) : super(key: key);

  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute> {

  int _selectIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scaffold'),
        actions: [
          IconButton(onPressed: () {
          }, icon: Icon(Icons.share)),
        ],
        leading: Builder(builder: (context) {
          return IconButton(onPressed: () {
            Scaffold.of(context).openDrawer();
          }, icon: Icon(Icons.dashboard, color: Colors.white,));
        },),
        backgroundColor: Colors.yellow,
        bottom: ,
      ),
      drawer: CustomDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.air), label: 'Air'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Music')
        ],
        currentIndex: _selectIndex,
        // fixedColor: Colors.blue,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onAdd,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  void _onAdd() {

  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(context: context, child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 38), child:  Row(
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: ClipOval(
                child: Image.asset('images/icon.webp', width: 80,),
              ),),
              Text('LeeWong', style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
          ),
          Expanded(child: ListView(children: [
            ListTile(leading: Icon(Icons.add), title: Text('Add Account'),),
            ListTile(leading: Icon(Icons.settings), title: Text('Manager Account'),),
          ],))
        ],
      ),
      ),
    );
  }
}

