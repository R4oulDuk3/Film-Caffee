import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/models/email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:film_caffe_aplikacija/services/auth_service.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({required this.toggle});
  final Function toggle;
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email="",password1="",password2="";
  RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp passwordValid = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  final _formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //final adminEmails = Provider.of<List<Email>?>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("Registracija",
              style: naslovStil
          ),
        ),
        body: Container(
          width: double.infinity,
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
                        decoration: decoration.copyWith(hintText: "email"),
                        validator: (val){
                          //if(val.isEmpty)return ""
                          return emailValid.hasMatch(val!)?null:"Nevalidan email";},
                        onChanged: (val){
                          setState(() {
                            email=val;
                          });
                        },
                      ),SizedBox(height: 20,),
                      TextFormField(
                          obscureText: true,
                        decoration: decoration.copyWith(hintText: "password",suffixIcon: Icon(Icons.password)),
                        validator: (val){
                          return passwordValid.hasMatch(password1)?null:"Nevalidna sifra";
                        },
                        onChanged: (val){
                          setState(() {
                            password1=val;
                          });

                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                          obscureText: true,
                        decoration: decoration.copyWith(hintText: "password",suffixIcon: Icon(Icons.password)),
                          validator: (val){
                            return (password1.compareTo(password2))==0?null:"Nevalidna sifra";
                          },
                        onChanged: (val){
                          setState(() {
                            password2=val;
                          });
                        },
                      ),


                      RaisedButton(
                        onPressed: () async {
                          if(_formKey.currentState!.validate()) {

                            await AuthService().signInEmailPassword(
                                email, password1);
                          }
                        },
                        child: Text("Registracija"),
                      ),Expanded(
                        child: Container(),
                      ),
                      Column(
                        children: [
                          Text("Nemate profil?"),
                          SizedBox(height: 10,),
                          RaisedButton(onPressed: (){widget.toggle();},child: Text("Login"),)
                        ],
                      )
                    ],
                  ),
                ),
              )
          ),
        )
    );
  }
}

