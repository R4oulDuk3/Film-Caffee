import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/Widgets/EventCard.dart';
import 'package:film_caffe_aplikacija/models/event.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:film_caffe_aplikacija/services/auth_service.dart';
import 'package:film_caffe_aplikacija/Widgets/drawer.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
//import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:card_swiper/card_swiper.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.adminMode}) : super(key: key);
  final bool adminMode;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  List<Event> events=[
    Event(
      imgURL:"https://via.placeholder.com/350x150",
      name:"Placeholder",
      date: DateTime.now(),
      description: '',

    )
  ];

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Event>newEvents = Provider.of<List<Event>?>(context)??[];
    if(newEvents.length!=0){
      events=newEvents;
    }
    //print("adminMode is:" + widget.adminMode.toString());
   // events.forEach((element) {print(element);});
    EventSwiper es =EventSwiper(events: events,);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      drawer: NavigationDrawerWidget(adminMode:widget.adminMode),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Glavna Strana",
            style: naslovStil
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
      ),
      body:
        Container(
          width: double.infinity,
          color: Colors.purple[700],
          child: SafeArea(

              child: GFCarousel(
                viewportFraction: 1.0,
                pagination: true,
                height: screenHeight,
                items: events.map(
                      (event) {
                    return EventCard(event: event);
                  },
                ).toList(),
                onPageChanged: (index) {

                },
              ),

            ),
          ),


    );


  }
}
/*
*
* Swiper(
                itemBuilder: (BuildContext context,int index){
                  if(events.length==0)
                    return Image.network(
                      "https://via.placeholder.com/350x150",
                      fit: BoxFit.fill,);


                  return EventCard(event: events[index],);
                },
                itemCount: events.length==0?1:events.length,
                pagination: new SwiperPagination(),
              //  control: new SwiperControl(),

                //controller: SwiperController(),
              )*/

class EventSwiper extends StatefulWidget {
  EventSwiper({required this.events}) ;
  final List<Event> events;
  @override
  _EventSwiperState createState() => _EventSwiperState();
}

class _EventSwiperState extends State<EventSwiper> {
  @override
  Widget build(BuildContext context) {
    return new Swiper(
      itemBuilder: (BuildContext context,int index){
        return Image.network("https://via.placeholder.com/350x150",fit: BoxFit.fill,);
      },
      itemCount: widget.events.length,
      pagination: new SwiperPagination(),
      control: new SwiperControl(),

      //controller: SwiperController(),
    );
  }
}



/*
* RaisedButton(onPressed: (){
      AuthService().signOut();

    },
        )
* */