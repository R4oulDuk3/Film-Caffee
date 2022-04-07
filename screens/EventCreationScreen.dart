
import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/Widgets/EventCreatorCard.dart';
import 'package:film_caffe_aplikacija/Widgets/drawer.dart';
import 'package:film_caffe_aplikacija/models/event.dart';
import 'package:film_caffe_aplikacija/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EventCreationScreen extends StatefulWidget {
  EventCreationScreen({Key? key,this.event}) : super(key: key);
  late Event? event=null;

  @override
  _EventCreationScreenState createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<EventCreationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text("Dogadjaji manager",
            style: GoogleFonts.roboto()
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
      ),
      body:SingleChildScrollView(
          child:
          Container(
            height:screenHeight ,
              child: EventCreatorCard(event:widget.event)
          ))

    );
  }
}
