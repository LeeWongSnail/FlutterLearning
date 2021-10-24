import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // 主轴的对齐方式 如果是Row则是有一个从左到右的 如果是Column则是有一个从上往下的
      //  start 主轴开始的方向  end 主轴结束的方向
      // spacebetween 将剩余空间在对象之间均匀放置
      // spacearound 将剩余空间放在对象直接以及左右两边
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // 交叉轴 交叉轴为与主轴垂直的轴
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconBadge(Icons.pool),
        IconBadge(Icons.air_sharp, size: 48,),
        IconBadge(Icons.email),
      ],
    );
  }
}



// return Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// IconBadge(Icons.pool),
// IconBadge(Icons.air_sharp),
// IconBadge(Icons.email),
// ],
class IconBadge extends StatelessWidget {
  final IconData icon;
  final double size;

  IconBadge(this.icon, {
    this.size = 32.0
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Icon(icon, size: size, color: Colors.white,),
      width: size+60,
      height: size+60,
      color: Colors.blue,
    );
  }
}