import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key, required this.adminMode}) : super(key: key);
  final bool adminMode;
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(child:SafeArea(child: Text("UserInfo"),));
  }
}
