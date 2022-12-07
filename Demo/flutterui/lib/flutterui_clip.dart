//
// class TransformPage extends StatelessWidget {
//   const TransformPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Transform'),),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           ClipOval(child: Container(
//             width: 120,
//             height: 120,
//             color: Colors.red,
//           ),),
//           ClipOval(child: Container(
//             width: 120,
//             height: 80,
//             color: Colors.red,
//           ),),
//           ClipRRect(borderRadius: BorderRadius.circular(20), child: Container(
//             width: 120,
//             height: 80,
//             color: Colors.red,
//           ),),
//           ClipRect(child: Container(
//             width: 120,
//             height: 60,
//             color: Colors.red,
//             child: Text('Hello World', style: TextStyle(fontSize: 40),),
//           ),),
//           ClipPath.shape(shape: StadiumBorder(), child: Container(
//             height: 150,
//             width: 250,
//             color: Colors.red,
//             child: FlutterLogo(),
//           )),
//           ClipPath(clipper: _TrianglePath(),child: Container(
//             width: 250,
//             height: 150,
//             color: Colors.red,
//             child: FlutterLogo(),
//           ),),
//         ],
//       ),
//     );
//   }
// }
//
// class _TrianglePath extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.moveTo(size.width / 2, 0);
//     path.lineTo(0, size.height);
//     path.lineTo(size.width, size.height);
//     path.close();
//     return path;
//   }
//
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }