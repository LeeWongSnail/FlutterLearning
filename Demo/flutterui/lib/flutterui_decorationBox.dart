// class DecoratedBoxDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           // 背景渐变
//           gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
//           // 3像素圆角
//           borderRadius: BorderRadius.circular(10.0),
//           shape: BoxShape.rectangle,
//           backgroundBlendMode: BlendMode.darken,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black54,
//               offset: Offset(2.0, 2.0),
//               blurRadius: 4.0,
//             )
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
//           child: Text('Login', style: TextStyle(color: Colors.white)),
//         ),
//       ),
//     );
//   }
// }