import 'package:flutter/material.dart';

class ContainerDemo extends StatelessWidget {
  const ContainerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Row(
        // 设置主轴对齐位置
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(Icons.pool, size: 24, color: Colors.white,),
            // color: Color.fromRGBO(3, 54, 255, 1),
            // 设置内边距
            padding: EdgeInsets.only(left: 30, top: 30),
            // 设置外边距
            margin: EdgeInsets.all(50.0),
            width: 100.0,
            height: 100.0,
            // 可以给container设置boxdecoration
            decoration: BoxDecoration(
              color:  Color.fromRGBO(3, 54, 255, 1),
              // 设置边框 可以设置所有的 也可以单独设置某一个
              border: Border.all(
                  color: Colors.red,
                  width: 3.0,
                  style: BorderStyle.solid
              ),
              // 设置圆角
              // borderRadius: BorderRadius.circular(15)
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(30)),
            ),

          )
        ],
      ),
    );
  }
}
