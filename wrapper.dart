import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:film_caffe_aplikacija/services/auth_service.dart';
import 'package:film_caffe_aplikacija/screens/home.dart';
import 'package:film_caffe_aplikacija/screens/register_screen.dart';
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);


  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool showSignIn=true;


  //get setAdminMode =>  setAdminMode(bool);
  void toggle(){
    setState(() {
      showSignIn=!showSignIn;
    });
  }



  @override
  Widget build(BuildContext context) {
    var padding= MediaQuery.of(context).padding;
    screenHeight=MediaQuery.of(context).size.height - padding.top - padding.bottom;;
    final user = Provider.of<User?>(context);
    List<String>? adminId = Provider.of<List<String>?>(context);
    if(user==null){
      if(showSignIn)return LoginScreen(toggle: toggle);
      return Register(toggle: toggle);
    }
    bool mode = false;
    //adminMode=false;
    if(adminId!=null)
    adminId!.forEach((element) {
      if(user.uid==element){
        print(user.uid);
        mode=true;
      }
    });
    return Container(child: HomePage(adminMode: mode,));
  }
}


