import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:film_caffe_aplikacija/Widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserSpecialOfferScreen extends StatefulWidget {
  const UserSpecialOfferScreen({Key? key,required this.adminMode}) : super(key: key);
  final bool adminMode;
  @override
  _UserSpecialOfferScreenState createState() => _UserSpecialOfferScreenState();
}

class _UserSpecialOfferScreenState extends State<UserSpecialOfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      drawer: NavigationDrawerWidget(adminMode:widget.adminMode),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text("Akcije",
            style: GoogleFonts.roboto()
        ),
      ),

      body: SafeArea(
        child: Container(
          color: Colors.purple,
          child:SingleChildScrollView(
            child: ListView(
              children: [],
            ),
          )
        ),
      ),
    );
  }
}
