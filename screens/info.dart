import 'package:flutter/material.dart';
class CaffeInfo extends StatefulWidget {
  const CaffeInfo({Key? key, required this.adminMode}) : super(key: key);
  final bool adminMode;
  @override
  _CaffeInfoState createState() => _CaffeInfoState();
}

class _CaffeInfoState extends State<CaffeInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(child:SafeArea(child: Text("CaffeInfo"),));
  }
}
