import 'package:film_caffe_aplikacija/Widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration decoration =InputDecoration(
      suffixIcon: Icon(Icons.email),
      hintText: 'Email',

      enabledBorder: OutlineInputBorder(
        //borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0
      )
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
        color: Colors.blue,
        width: 1.0
        )
        ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: Colors.red,
              width: 1.0
          )
      ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
      color: Colors.red,
      width: 1.0
      )
      )
  );
final TextStyle naslovStil = GoogleFonts.bebasNeue(
  fontSize: 28,
  wordSpacing: 2
);
final TextStyle opisStil = GoogleFonts.anticSlab(
  fontSize: 14,
);
final TextStyle dugmeStil = GoogleFonts.passionOne(
  fontSize: 18,
);
final TextStyle drawerStil = GoogleFonts.bebasNeue(
  fontSize: 20,
  letterSpacing: 4
);
final TextStyle dogadjajNaslovStil = GoogleFonts.bebasNeue(
  fontSize: 20,
    letterSpacing: 4
);
double screenHeight=0;

NavigationDrawerWidget userDrawer = NavigationDrawerWidget(adminMode: false);
NavigationDrawerWidget adminDrawer = NavigationDrawerWidget(adminMode: true);