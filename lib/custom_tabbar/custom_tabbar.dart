import 'package:flutter/material.dart';

class CustomTabbarPage extends StatefulWidget {
  const CustomTabbarPage({Key? key}) : super(key: key);

  @override
  _CustomTabbarPageState createState() => _CustomTabbarPageState();
}

class _CustomTabbarPageState extends State<CustomTabbarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){

          },
          tooltip: 'this is floating button',
          child: Icon(
            Icons.add, color: Colors.white,
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.home)),
            IconButton(onPressed: (){}, icon: Icon(Icons.email)),
            IconButton(onPressed: (){}, icon: Icon(Icons.pages)),
            IconButton(onPressed: (){}, icon: Icon(Icons.airplay)),

          ],
        ),
      ),
    );
  }
}
