import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_caffe_aplikacija/models/email.dart';
import 'package:film_caffe_aplikacija/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:film_caffe_aplikacija/services/auth_service.dart';
import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.toggle,});
  final Function toggle;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email="",password="";
  RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


   // final adminEmails = Provider.of<List<Email>?>(context);
   // if(adminEmails!=null) adminEmails.forEach((element) {print(element);});

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Login",
          style: naslovStil
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          //width: double.infinity,
          height: screenHeight+MediaQuery.of(context).padding.top,
        decoration: BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                (Colors.purple[900])!,
                (Colors.purple[800])!,
                (Colors.purple[400])!
              ],
            )
          ),
          child: SafeArea(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    children: [
                      TextFormField(
                        decoration: decoration,
                        validator: (val)=>emailValid.hasMatch(val!)?null:"Nevalidan email",
                        onChanged: (val){
                          setState(() {
                            email=val;
                          });
                        },
                      ),SizedBox(height: 20,),
                      TextFormField(
                        obscureText: true,
                          decoration: decoration.copyWith(hintText: "password",suffixIcon: Icon(Icons.password)),
                        onChanged: (val){
                          setState(() {
                            password=val;
                          });
                        },
                      ),Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0,horizontal: 25.0),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () async{
                            if(_formKey.currentState!.validate()) {
                               await AuthService()
                                  .signInEmailPassword(email, password);
                            }
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            'LOGIN',
                            style: dugmeStil,
                          ),
                        ),
                      ),
                      SignInButton(
                        Buttons.Google,
                        onPressed: () {
                          AuthService().signInWithGoogle(context: context);
                        },
                      )

                      ,Expanded(
                          child: Container(),
                      ),
                      Column(
                        children: [
                          Text("Nemate profil?",style: opisStil,),
                          SizedBox(height: 10,),
                          RaisedButton(onPressed: (){widget.toggle();},child: Text("Registracija",style: dugmeStil,),)
                        ],
                      )
                    ],
                ),
              ),
            )
          ),
        ),
      )
    );
  }
}
