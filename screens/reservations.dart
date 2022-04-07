import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/Widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservationScreen extends StatefulWidget {
  ReservationScreen({Key? key, required this.adminMode}) : super(key: key);
  final bool adminMode;
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: NavigationDrawerWidget(adminMode:widget.adminMode),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("Rezervacije",
              style: naslovStil
          ),
        ),
        body: Container(
          width: double.infinity,
          color: Colors.purple,
          child: SafeArea(
            child: Column(

            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
        )
    );

  }
}
