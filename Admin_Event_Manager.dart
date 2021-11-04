import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/Widgets/EventCreatorCard.dart';
import 'package:film_caffe_aplikacija/Widgets/drawer.dart';
import 'package:film_caffe_aplikacija/models/event.dart';
import 'package:film_caffe_aplikacija/screens/EventCreationScreen.dart';
import 'package:film_caffe_aplikacija/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../HeroDialogRoute.dart';
import 'CreatorCard.dart';

class EventManager extends StatefulWidget {
  const EventManager({Key? key, required this.adminMode}) : super(key: key);
  final bool adminMode;
  @override
  _EventManagerState createState() => _EventManagerState();
}

class _EventManagerState extends State<EventManager> {
  DatePicker datePicker = DatePicker();
  DateTime? dateTime=null;
  final _picker = ImagePicker();
  String eventName="";
  String eventDesc="";
  XFile? _image=null;
  List<Event> events = [];
  List<Widget> eventTiles=[];
  @override
  Widget build(BuildContext context) {
    events = Provider.of<List<Event>?>(context)??[];
    eventTiles=[];
    events.forEach((element) {
      eventTiles.add(SizedBox(height: 10,));
      eventTiles.add(
        EventListTile(event: element),
      );

    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavigationDrawerWidget(adminMode:widget.adminMode),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Dogadjaji manager",
            style: GoogleFonts.roboto()
        ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: "eventCreator",
        backgroundColor: Colors.white,
        onPressed: (){
          Navigator.of(context).push(HeroDialogRoute(builder:
              (context){
            return CreatorCard(
              content:EventCreatorCard(),
              heroTag: "eventCreator",
            );
           },
          )
          );
          },
        child: Icon(Icons.add,color: Colors.black,)
        ),

      body:
      Container(
        width: double.infinity,
        color: Colors.purple,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children:eventTiles
            ),
          ),
        ),
      ),
    );
  }
}

class EventListTile extends StatefulWidget {
  EventListTile({required this.event});
  Event event;
  @override
  _EventListTileState createState() => _EventListTileState();
}

class _EventListTileState extends State<EventListTile> {
  @override
  Widget build(BuildContext context) {
    return Hero(

      tag: "eventModifier",
      child: Slidable(
        actionPane: SlidableDrawerActionPane(
        ),
        actionExtentRatio: 0.20,
        child: Container(
          color: Colors.white,

          child: Material(
            child: ListTile(
              title: Text(widget.event.name),
              subtitle: Text(widget.event.date.toString()),
             // isThreeLine: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              trailing: Icon(Icons.arrow_back),
              tileColor: Colors.white,


            ),
          ),
        ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Izmeni',
              color: Colors.yellow,
              icon: Icons.change_circle,
              onTap: (){

                  Navigator.of(context).push(HeroDialogRoute(builder:
                      (context){
                    return CreatorCard(
                      content:EventCreatorCard(event: widget.event,),
                      heroTag: "eventModifier",
                    );}
                  ));
                }
              ,
            ),
            IconSlideAction(
              caption: 'Obrisi',
              color: Colors.red,
              icon: Icons.delete,
              onTap: (){
                setState(() {
                  DatabaseService().deleteEvent(
                      widget.event
                  );
                });
                },
            ),

          ]
      ),
    );
  }
}


/*return Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 10,),
              RaisedButton(onPressed: () async{
                    dateTime=await DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                    print(dateTime.toString());
              },
                child: Text("Odaberi Datum"),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: decoration.copyWith(
                    suffixIcon: Icon(Icons.edit),
                    hintText: "Naziv dogadjaja"
                ),
                onChanged: (val){
                  setState(() {
                    eventName=val;
                  });
                },
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: decoration.copyWith(
                    suffixIcon: Icon(Icons.edit),
                    hintText: "Naziv dogadjaja"
                ),
                onChanged: (val){
                  setState(() {
                    eventDesc=val;
                  });
                },
              ),
              SizedBox(height: 10,),
              RaisedButton(onPressed: ()async{
                _image = await _picker.pickImage(source: ImageSource.gallery);
              },
                child: Text("Odaberi sliku"),),
              SizedBox(height: 10,),
              RaisedButton(onPressed: ()async{
                if(_image!=null && eventName!="" && dateTime!=null) {
                  String imgURL = await DatabaseService().uploadFile(_image!);
                  Event event = Event(
                      imgURL: imgURL,
                      name: eventName,
                      date: dateTime!,
                    description: eventDesc
                  );
                  await DatabaseService().addEvent(event);
                  print("Uspesno dodavanje");
                }
              },
                child: Text("Postavi dogadjaj"),)

            ],
          ),
        );
        Column(
            children: [
              RaisedButton(
                  onPressed:(){ Navigator.push(context,
                  MaterialPageRoute(builder:
                      (context)=>EventCreationScreen())
                  );
                  },
                child: Text("Dodaj dogadjaj"),
              ),
              SizedBox(height: 15,),
              RaisedButton(
                onPressed: (){},
                child: Text("Izbrisi dogadjaj"),
              ),
              SizedBox(height: 10,),
              RaisedButton(
                onPressed: (){},
                child: Text("Izmeni dogadjaj"),
              )
            ],
          )
        */