import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   // 主轴的对齐方式 如果是Row则是有一个从左到右的 如果是Column则是有一个从上往下的
    //   //  start 主轴开始的方向  end 主轴结束的方向
    //   // spacebetween 将剩余空间在对象之间均匀放置
    //   // spacearound 将剩余空间放在对象直接以及左右两边
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   // 交叉轴 交叉轴为与主轴垂直的轴
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     IconBadge(Icons.pool),
    //     IconBadge(Icons.air_sharp, size: 48,),
    //     IconBadge(Icons.email),
    //   ],
    // );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 类似stackview 表示一组小控件 可以使用Positioned精确的设置某一个小控件的位置
          Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                width: 200.0,
                height: 200.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue
                  ),
                  child: Text('这是一个text', style: TextStyle(color: Colors.blue,backgroundColor: Colors.grey),),
                ),
              ),
              Positioned(child: Icon(Icons.ac_unit, color: Colors.white, size: 16,), right: 0, top: 10,),
              Positioned(child: Icon(Icons.ac_unit, color: Colors.white, size: 16,), right: 10, top: 20,),
              Positioned(child: Icon(Icons.ac_unit, color: Colors.white, size: 16,), right: 20, top: 30,),
              Positioned(child: Icon(Icons.ac_unit, color: Colors.white, size: 16,), right: 60, top: 40,),
              Positioned(child: Icon(Icons.ac_unit, color: Colors.white, size: 16,), right: 70, top: 50,),
              Positioned(child: Icon(Icons.ac_unit, color: Colors.white, size: 16,), right: 30, top: 60,),
              Positioned(child: Icon(Icons.ac_unit, color: Colors.white, size: 16,), right: 50, top: 70,),

              SizedBox(
                width: 200.0,
                height: 100.0,
                child: Icon(Icons.airplay, size: 50,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//
// return Container(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// // Size Box 常用来包裹一个子控件， 默认子控件是由内部内容决定大小 但是添加了SizeBox后就可以设置为一个固定的大小
// // 通常SizeBox也可以用来做两个空间之间的间隙
// SizedBox(
// height: 100,
// ),
// SizedBox(
// width: 200.0,
// height: 100.0,
// child: Container(
// //alignment 表示对齐， 可以通过x和y的坐标轴来设置
// // 可以以通过Alignment中的几个枚举选项来进行设置例如 topCenter
// // alignment: Alignment(1.0, 1.0),
// alignment: Alignment.topCenter,
// decoration: BoxDecoration(
// color: Colors.red
// ),
// child: Icon(Icons.ac_unit, color: Colors.white, size: 32,),
// ),
// ),
// SizedBox(
// width: 200.0,
// height: 100.0,
// child: Container(
// decoration: BoxDecoration(
// color: Colors.red
// ),
// child: Icon(Icons.ac_unit, color: Colors.white, size: 32,),
// ),
// )
// ],
// ),
// );

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