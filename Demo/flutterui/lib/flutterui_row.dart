// Row(
// // textDirection: TextDirection.rtl,
// // mainAxisSize: MainAxisSize.min,
// // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// verticalDirection: VerticalDirection.down,
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// Text('Hello-'),
// Text('This is my number-'),
// Text('Call me maybe-', style: TextStyle(fontSize: 30),),
// ],
// )

// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
// children: <Widget>[
// Expanded(child: Container(
// color: Colors.red,
// child: Column(
// mainAxisSize: MainAxisSize.max,//无效，内层Colum高度为实际高度
// children: <Widget>[
// Text("hello world "),
// Text("I am Jack "),
// ],
// ),
// )),
// ],
// ),