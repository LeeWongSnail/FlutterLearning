//
//
// class ResponsiveColumn extends StatelessWidget {
//   const ResponsiveColumn({Key? key, required this.children}) : super(key: key);
//
//   final List <Widget> children;
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
//       if (constraints.maxWidth < 200) {
//         // 最大的宽度小于200 则显示单列
//         return Column(children: children, mainAxisSize: MainAxisSize.min,);
//       } else {
//         // 最大宽度大于200 则展示双列
//         // 这里需要将数据拆分成一行两列的形式
//         var _children = <Widget>[];
//         for(var i = 0; i < children.length; i = i+2) {
//           // 需要判断是否还存在下一个
//           if (i+1 < children.length) {
//             // 还有下一个
//             _children.add(Row(
//               children: [children[i], children[i+1]],
//               mainAxisSize: MainAxisSize.min,
//             ));
//           } else {
//             _children.add(children[i]);
//           }
//         }
//         return Column(children: _children, mainAxisSize: MainAxisSize.min,);
//       }
//     });
//   }
// }
//
//
// class LayoutBuilderRoute extends StatelessWidget {
//   const LayoutBuilderRoute({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var _children = List.filled(6, Text('A'));
//     // Column 在本市李忠在水平方向的最大宽度为屏幕的宽度
//     return Column(
//       children: [
//         Container(width: 100, height: 100,),
//         SizedBox(width: 190, child: ResponsiveColumn(children: _children,),),
//         ResponsiveColumn(children: _children),
//         LayoutLogPrint(child: Text('AA')), // flutter: Text("AA"): BoxConstraints(0.0<=w<=393.0, 0.0<=h<=Infinity)
//       ],
//     );
//   }
// }
//
// class LayoutLogPrint<T> extends StatelessWidget {
//   const LayoutLogPrint ({Key? key, this.tag, required this.child}) : super(key: key);
//
//   final Widget child;
//   final T? tag; // 指定的日志
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (_, constraints) {
//       assert(() {
//         print('${tag ?? key ?? child}: $constraints');
//         return true;
//       }());
//       return child;
//     });
//   }
// }
