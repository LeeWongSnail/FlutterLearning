// Column(
// children: [
// // ConstrainedBox(
// //   constraints: BoxConstraints(
// //     minHeight: 50,
// //     minWidth: 50,
// //   ),
// //   child: Container(
// //     height: 80,
// //     color: Colors.red,
// //   ),
// // ),
// // Padding(padding: EdgeInsets.only(top: 20)),
// // SizedBox(
// //   width: 100,
// //   height: 100,
// //   child: redBox,
// // ),
// // Padding(padding: EdgeInsets.only(top: 20)),
// // ConstrainedBox(constraints: BoxConstraints.tightFor(width: 50, height: 50), child: redBox,),
// ConstrainedBox(
// constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0),  //父
// child: UnconstrainedBox( //“去除”父级限制
// child: ConstrainedBox(
// constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),//子
// child: redBox,
// ),
// ),
// ),
// ],
// ),