
import 'package:film_caffe_aplikacija/Widgets/SpecialOfferCreatorCard.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/Widgets/EventCreatorCard.dart';
import 'package:film_caffe_aplikacija/Widgets/drawer.dart';
import 'package:film_caffe_aplikacija/models/EventReservationList.dart';
import 'package:film_caffe_aplikacija/models/Reservation.dart';
import 'package:film_caffe_aplikacija/models/Table.dart';
import 'package:film_caffe_aplikacija/models/event.dart';
import 'package:film_caffe_aplikacija/screens/EventCreationScreen.dart';
import 'package:film_caffe_aplikacija/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';
import '../HeroDialogRoute.dart';
import 'CreatorCard.dart';

class AdminSpecialOfferManager extends StatefulWidget {
  const AdminSpecialOfferManager({Key? key,required this.adminMode}) : super(key: key);
  final bool adminMode;
  @override
  _AdminSpecialOfferManagerState createState() => _AdminSpecialOfferManagerState();
}

class _AdminSpecialOfferManagerState extends State<AdminSpecialOfferManager> {
  int pageIndex=0;

  @override
  Widget build(BuildContext context) {
    Provider.of<List<Event>?>(context)??[];
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: pageIndex==0?FloatingActionButton(
          heroTag: "specialOfferCreator",
          onPressed: (){
            Navigator.of(context).push(HeroDialogRoute(builder:
                (context){
              return CreatorCard(
                content:SpecialOfferCreatorCard(),
                heroTag: "specialOfferCreator",
              );
            },
            )
            );
          },
          backgroundColor: Colors.white,
          child: Icon(Icons.add,color: Colors.black,)
      ):null,
      extendBodyBehindAppBar: true,
      drawer: NavigationDrawerWidget(adminMode:widget.adminMode),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(pageIndex==0?"Nova Akcija":"Skeniraj akciju",
            style: GoogleFonts.roboto()
        ),

      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.purple,
        color: Colors.white,
        items: <Widget>[
          Icon(Icons.free_breakfast, size: 30,color: Colors.black,),
          Icon(Icons.lightbulb, size: 30,color: Colors.black,),
          //Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) async {
          setState(() {
            pageIndex=index;
          });

        },
      ),
      body: SafeArea(
        child: Container(
            color: Colors.purple,
            //child:
        ),
      ),
    );

  }
}
