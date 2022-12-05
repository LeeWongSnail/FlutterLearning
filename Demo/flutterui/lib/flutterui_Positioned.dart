// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Box'),
//     ),
//     body: ConstrainedBox(
//       constraints: BoxConstraints.expand(),
//       child: Stack(
//         alignment: Alignment.center,
//         fit: StackFit.expand,
//         clipBehavior: Clip.hardEdge,
//         children: [
//           Positioned(child: Text('I am LeeWong'), left: 20,),
//           Container(child: Text('Hello World', style: TextStyle(color: Colors.white),), color: Colors.red,),
//           Positioned(child: Text('Your Friends'), top: 20,),
//         ],
//       ),
//     ),
//   );
// }