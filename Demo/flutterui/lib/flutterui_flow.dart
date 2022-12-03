// body: Wrap(
// spacing: 8.0,
// runSpacing: 4.0,
// alignment: WrapAlignment.center,
// children: [
// Chip(label: Text('Hamilton'),
// avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A'),),),
// Chip(label: Text('Lafayette'),
// avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M'),),),
// Chip(label: Text('Mulligan'),
// avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('H'),),),
// Chip(label: Text('Laurens'),
// avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J'),),)
// ],
// ),

//
// class TestFlowDelegate extends FlowDelegate {
//   EdgeInsets margin;
//
//   TestFlowDelegate({this.margin = EdgeInsets.zero});
//
//   double width = 0;
//   double height = 0;
//
//   @override
//   void paintChildren(FlowPaintingContext context) {
//     // TODO: implement paintChildren
//     var x = margin.left;
//     var y = margin.top;
//     // 计算每一个子widget的位置
//     for (int i = 0; i < context.childCount; i++) {
//       var w = context.getChildSize(i)!.width + x + margin.right;
//       if(w < context.size.width) {
//         context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
//         x = w + margin.left;
//       } else {
//         x = margin.left;
//         y += context.getChildSize(i)!.height + margin.top + margin.bottom;
//         // 绘制子widget
//         context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
//         x += context.getChildSize(i)!.width + margin.left + margin.right;
//       }
//     }
//   }
//
//   @override
//   Size getSize(BoxConstraints constraints) {
//     // TODO: implement getSize
//     // 指定flow的大小，简单起见我们让宽度尽可能的大，但高度指定为200
//     // 实际开发中我们需要根据子元素所占用的具体宽高来设置flow大小
//     return Size(double.infinity, 250);
//   }
//
//   @override
//   bool shouldRepaint(covariant FlowDelegate oldDelegate) {
//     // TODO: implement shouldRepaint
//     return oldDelegate != this;
//   }
//
// }
//
//
// class ProgressRoute extends StatefulWidget {
//   const ProgressRoute({Key? key}) : super(key: key);
//
//   @override
//   _ProgressRouteState createState() => _ProgressRouteState();
// }
//
// class _ProgressRouteState extends State<ProgressRoute> with SingleTickerProviderStateMixin {
//
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     _animationController = AnimationController(vsync: this, duration: Duration(seconds: 10));
//     _animationController.forward();
//     _animationController.addListener(() => setState(() => {}));
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Box'),
//       ),
//       body: Flow(
//         delegate: TestFlowDelegate(margin: EdgeInsets.all(25.0)),
//         children: [
//           Container(width: 80.0, height:80.0, color: Colors.red,),
//           Container(width: 80.0, height:80.0, color: Colors.green,),
//           Container(width: 80.0, height:80.0, color: Colors.blue,),
//           Container(width: 80.0, height:80.0,  color: Colors.yellow,),
//           Container(width: 80.0, height:80.0, color: Colors.brown,),
//
//           Container(width: 80.0, height:80.0,  color: Colors.purple,),
//         ],
//       ),
//     );
//   }
// }