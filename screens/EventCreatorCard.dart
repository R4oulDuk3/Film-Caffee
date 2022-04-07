import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/Widgets/drawer.dart';
import 'package:film_caffe_aplikacija/models/Table.dart';
import 'package:film_caffe_aplikacija/models/event.dart';
import 'package:film_caffe_aplikacija/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';
class EventCreatorCard extends StatefulWidget {
  EventCreatorCard({Key? key,this.event}) : super(key: key);
  Event? event;
  @override
  _EventCreatorCardState createState() => _EventCreatorCardState();
}

class _EventCreatorCardState extends State<EventCreatorCard> {

  String name="";
  String desc="";
  DateTime? date=null;
  final _picker = ImagePicker();
  File? _image=null;
  TablesLayout? _chosenLayout=null;
  @override
  void initState(){
    Event ? event = widget.event;
    name =widget.event!=null?widget.event!.name:"";
    desc = event!=null?event.description:desc;
    date = event!=null?event.date:date;
 //   image = widget.event!=null?widget.event.
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Event? event = widget.event;
    List<TablesLayout> layouts = Provider.of<List<TablesLayout>?>(context)??[];
   // print("rebuild");
    //List<String> layoutNames =[];

    return SingleChildScrollView(
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              child: InkWell(
                onTap: () async {
                  XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if(image!=null)
                  setState(() {
                    _image=File(image!.path);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: _image==null?Image.network(widget.event!=null?
                  widget.event!.imgURL:"https://via.placeholder.com/350x150"
                  ):Image.file(_image!),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DropdownButton< TablesLayout?>(
                focusColor:Colors.white,
                value: _chosenLayout,
                //elevation: 5,
                style: TextStyle(color: Colors.white),
                iconEnabledColor:Colors.black,
                items: layouts.map<DropdownMenuItem< TablesLayout?>>((TablesLayout value) {
                  return DropdownMenuItem<TablesLayout>(
                    value: value,
                    child: Text(value.name,style:TextStyle(color:Colors.black),),
                  );
                }).toList(),
                hint:Text(
                  "Odaberi postavku stolova",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                onChanged:(value) {
                  setState(() {
                    _chosenLayout=value;
                  });
                },
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              child: Text(
                date==null?"Odaberi datum":date.toString(),
                style: opisStil,
              ),
              onTap: ()async{
                final dateTemp=await DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                setState(() {
                  date=dateTemp;
                  print(date.toString());
                });

              },
            ),
            Divider(
              color: Colors.black,
            ), TextFormField(
              initialValue: name,
              decoration: InputDecoration(
                  hintText: "Naslov"
              ),
              onChanged: (val){
                setState(() {
                  name=val;
                  print(name);
                });
              },
            ),SizedBox(height: 10,),
            TextFormField(
              initialValue: desc,
              decoration: InputDecoration(
                  hintText: "Opis"
              ),
              onChanged: (val){
                desc=val;
              },
              maxLines: 2,
            ),
            RaisedButton(onPressed: ()async{
              if(event==null){
                if(_image!=null && name!="" && date!=null && _chosenLayout!=null) {
                  String imgURL = await DatabaseService().uploadFile(_image!);
                  Event event = Event(
                      imgURL: imgURL,
                      name: name,
                      date: date!,
                      description: desc,
                  );
                  String eventId =await DatabaseService().addEvent(event);
                  event.id=eventId;
                  String reservationId =await
                  DatabaseService().addFreeTables(_chosenLayout!,event);

                  print("Uspesno dodavanje");
                }
              }else{
                if(name!="" && date!=null){
                  String imgURL = event!.imgURL;
                  if(_image!=null){
                    imgURL = await DatabaseService().uploadFile(_image!);
                  }
                  print("Naslov == "+ name);
                  Event newEvent = Event(
                      imgURL: imgURL,
                      name: name,
                      date: date!,
                      description: desc,
                      id:event!.id,

                  );
                  print("Izmenjeni event "+newEvent.toString());
                  await DatabaseService().updateEvent(newEvent);

                }
              }
            },
              child:
              event!=null?Text(
                "Izmeni dogadjaj",style: dugmeStil,
              ):Text("Postavi dogadjaj",style: dugmeStil,),)

          ],
        ),
      ),
    );
  }
}
