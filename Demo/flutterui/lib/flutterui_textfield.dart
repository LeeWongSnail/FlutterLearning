// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Switch(value: _switchSelected, onChanged: (value){
// setState(() {
// _switchSelected = value;
// });
// },),
//
// Checkbox(value: _checkboxSelected, onChanged: (value){
// setState(() {
// _checkboxSelected = value!;
// });
// }, activeColor: Colors.red, ),
// ],
// ),

// TextField(autofocus: true,decoration: InputDecoration(
// // labelText: '请输入用户名',
// hintText: '用户名或者邮箱',
// prefix: Icon(Icons.person),
// // fillColor: Colors.red,
// // filled: true,
// enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
// focusedBorder: UnderlineInputBorder(
// borderSide: BorderSide(color: Colors.green),
// ),
// ),onChanged: (value){
// print(value);
// },focusNode: _emailFocusNode,keyboardType: TextInputType.emailAddress,textInputAction: TextInputAction.next,),
// TextField(cursorColor: Colors.green, cursorWidth: 6, cursorRadius: Radius.circular(3)
// , inputFormatters: [
// FilteringTextInputFormatter.allow(RegExp('[a-z]'))
// ],decoration: InputDecoration(
// labelText: '请输入密码',
// hintText: '输入密码包含字母和数字',
// prefix: Icon(Icons.password)
// ),controller: _unnamedController,textAlign: TextAlign.right),