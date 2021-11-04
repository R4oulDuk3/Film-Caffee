import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/Widgets/ReservationCreatorCard.dart';
import 'package:film_caffe_aplikacija/screens/CreatorCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:film_caffe_aplikacija/models/event.dart';
import 'package:getwidget/getwidget.dart';

import '../HeroDialogRoute.dart';

class EventCard extends StatefulWidget {
  const EventCard({Key? key, required this.event}) : super(key: key);
  final Event event;
  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.event.imgURL);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0,vertical:16.0 ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children:[ Image.network(
              widget.event.imgURL,
              fit: BoxFit.fill,
              height: screenHeight,
              width: MediaQuery.of(context).size.width
              ),
            Positioned(
              bottom: 0,
                height: screenHeight*0.20,
                width: MediaQuery.of(context).size.width,
                child: GFCard(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  color: Colors.black.withOpacity(0.5),
                  titlePosition: GFPosition.start,
                  title: GFListTile(
                    title: Text(widget.event.name,
                    style: naslovStil,),
                    subTitle: Text(
                      widget.event.description,
                      style: opisStil,
                    ),
                  ),
                    buttonBar: GFButtonBar(

                      children: <Widget>[


                        Row(
                          children: [
                            Expanded(child: Container()),
                            Hero(
                              tag: "reservation",
                              child: GFButton(
                                size: 50,
                                color: Colors.white.withOpacity(1.0),
                                onPressed: () {
                                  Navigator.of(context).push(HeroDialogRoute(builder:
                                      (context){
                                      return CreatorCard(content:
                                      ReservationCreator(event: widget.event,),
                                      heroTag: "reservation",);
                                    },
                                    )
                                  );
                                },
                                text: 'Rezerviši',
                                textStyle: dogadjajNaslovStil.copyWith(color: Colors.black),
                                icon: Icon(Icons.coffee,color: Colors.black,),
                              ),
                            ),
                            SizedBox(width: 40,)
                          ],
                        ),

                      ],
                    )
              )
            ),
          ]
        )
          )
    );

  }
}
/*Ink.image(
                image: Image.network(
                    widget.event.imgURL,
                ).image,
                fit: BoxFit.fill,
              )*/

/*
* return Card(

      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
      side: BorderSide(color: Colors.black, width: 6)),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              flex: 9,
              child:
                  Ink.image(image:Image.network(
                    widget.event.imgURL,
                  ).image,
                    fit: BoxFit.fill,
                   // height: 450,
                   // width: double.infinity,
                  ),
            ),


            Flexible(
              fit: FlexFit.loose,
               flex: 4,
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(widget.event.name,
                     style: dogadjajNaslovStil),
                      // bottom: 16,
                       //left: 36,
                       //right: 16,

                     Divider(
                       color: Colors.black,
                     ),
                     Text(widget.event.description,
                     style: opisStil,),
                     Expanded(child: Container()),
                     Center(
                       child: RaisedButton(
                           onPressed: (){},
                         child: Text("Rezerviši mesto!",
                         style: dugmeStil,),
                       ),
                     ),

                   ],
                 ),
               ),
             ),





          ],
        ),

    );*/