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
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             height: 120,
//             width: 120,
//             color: Colors.blue.shade50,
//             child: Align(
//               alignment: Alignment.topRight,
//               child: FlutterLogo(size: 30,),
//             ),
//           ),
//           Container(
//             color: Colors.blue.shade50,
//             child: Align(
//               widthFactor: 4,
//               heightFactor: 4,
//               alignment: Alignment.topCenter,
//               child: FlutterLogo(size: 30,),
//             ),
//           ),
//           Container(
//             color: Colors.blue.shade50,
//             child: Align(
//               widthFactor: 4,
//               heightFactor: 4,
//               alignment: Alignment(0,-1), // (Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2)
//               child: FlutterLogo(
//                 size: 30,
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.green.shade50,
//             width: 120,
//             height: 120,
//             child: Align(
//               alignment: FractionalOffset(0,0),
//               child: FlutterLogo(
//                 size: 30,
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.yellow.shade50,
//             width: 120,
//             height: 120,
//             child: Center(
//               widthFactor: 1,
//               heightFactor: 1,
//               child: Text('这段文本',),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }