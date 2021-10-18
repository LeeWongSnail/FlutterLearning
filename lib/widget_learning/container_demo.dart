import 'package:flutter/material.dart';

class ContainerDemo extends StatelessWidget {
  const ContainerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Row(
        children: [
          Container(
            child: Icon(Icons.pool, size: 24, color: Colors.white,),
            color: Color.fromRGBO(3, 54, 255, 1),
            padding: EdgeInsets.only(left: 30, top: 30),
            margin: EdgeInsets.all(95.0),
            width: 100.0,
            height: 100.0,
          )
        ],
      ),
    );
  }
}
