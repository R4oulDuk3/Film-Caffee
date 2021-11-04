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

class AdminReservationManagerScreen extends StatefulWidget {
  const AdminReservationManagerScreen({required this.adminMode});
  final bool adminMode;
  @override
  _AdminReservationManagerScreenState createState() => _AdminReservationManagerScreenState();
}

class _AdminReservationManagerScreenState extends State<AdminReservationManagerScreen> {
  int pageIndex=0;

  @override
  Widget build(BuildContext context) {
    var freeTables=Provider.of<List<FreeTable>?>(context)??[];
    var approvedReservations =Provider.of<List<ApprovedReservation>?>(context)??[];
    var pendingReservations =Provider.of<List<PendingReservation>?>(context)??[];
    freeTables.forEach((element) {print(element);});
    approvedReservations.forEach((element) {print(element); });
    pendingReservations.forEach((element) {print(element); });
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: NavigationDrawerWidget(adminMode:widget.adminMode),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text(pageIndex==1?"Slobodni Stolovi":
          (pageIndex==2?"Pristigle Rezervacije":"Potvrdjene Rezervacije"),
          style: GoogleFonts.roboto()
        ),

        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.purple,
          color: Colors.white,
          items: <Widget>[
            Icon(Icons.free_breakfast, size: 30,color: Colors.black,),
            Icon(Icons.lightbulb, size: 30,color: Colors.black,),
            Icon(Icons.check, size: 30,color: Colors.black,),
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
            child: pageIndex==0?
            freeTables!=[]?_freeTablesList(freeTables):Container():
            (pageIndex==1?_pendingReservationList(pendingReservations):
            _approvedReservationList(approvedReservations))
          ),
        ),
    );
  }
}
Widget _pendingReservationList(List<PendingReservation> list){
  return GroupedListView<PendingReservation, String>(
    elements: list,
    groupBy: (element) => element.eventName,
    groupComparator: (value1, value2) => value2.compareTo(value1),
    itemComparator: (item1, item2) =>
        item1.id.compareTo(item2.id),
    order: GroupedListOrder.DESC,
    groupSeparatorBuilder: (String value) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
    ),
      itemBuilder: (c, element) {
       return Padding(
         padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
         child: Material(
           color: Colors.white,
             shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            //elevation: 8.0,
           //margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
           child: Column(
                children: [GFListTile(
                  //leading: Icon(Icons.account_circle),
                  title: Text(
                    element.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  //subTitle: Text("Broj prestalih stolova: ${element}"),
                ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GFIconButton(
                          onPressed:(){},
                          icon: Icon(Icons.more_horiz),
                          shape: GFIconButtonShape.circle,
                        ),
                        SizedBox(width: 5,),
                        GFIconButton(
                          onPressed:()async{
                            await DatabaseService().approvePendingReservation(
                                element);
                          },
                          icon: Icon(Icons.check),
                            shape: GFIconButtonShape.circle
                        ),SizedBox(width: 5,),
                        GFIconButton(
                          onPressed:()async{
                            await DatabaseService().denyPendingReservation(
                                element);
                          },
                            icon: Icon(Icons.delete),
                            shape: GFIconButtonShape.circle
                        )
                      ],
                    ),
                  )
                ]
            ),
          ),
       );
      }
  );
}
Widget _approvedReservationList(List<ApprovedReservation> list){
  return GroupedListView<ApprovedReservation, String>(
      elements: list,
      groupBy: (element) => element.eventName,
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) =>
          item1.id.compareTo(item2.id),
      order: GroupedListOrder.DESC,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      itemBuilder: (c, element) {
        return Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0,
              vertical: 6.0),
          child: Column(
            children: [GFListTile(
              //leading: Icon(Icons.account_circle),
              title: Text(
                element.toString(),
                style: TextStyle(fontSize: 16),
              ),
              //subTitle: Text("Broj prestalih stolova: ${element}"),
            ),
              GFButton(
                onPressed:(){},
                text: "Prikazi informacije o korisniku",
                shape: GFButtonShape.pills,
              )
            ]
          ),
        );
      }
  );
}
Widget _freeTablesList(List<FreeTable> list){
 return GroupedListView<FreeTable, String>(
     elements: list,
   groupBy: (element) => element.eventName,
   groupComparator: (value1,
       value2) => value2.compareTo(value1),
   itemComparator: (item1, item2) =>
       item1.tableId!.compareTo(item2.tableId!),
   order: GroupedListOrder.DESC,
   // useStickyGroupSeparators: true,
   groupSeparatorBuilder: (String value) => Padding(
     padding: const EdgeInsets.all(8.0),
     child: Text(
       value,
       textAlign: TextAlign.left,
       style: TextStyle(fontSize: 18,
           fontWeight: FontWeight.bold),
     ),
   ),
   itemBuilder: (c, element) {
     return Card(
       elevation: 8.0,
       margin: new EdgeInsets.symmetric(horizontal: 10.0,
           vertical: 6.0),
       child: Container(
         child: GFListTile(
           //leading: Icon(Icons.account_circle),
           title: Text(
             element.toString(),
             style: TextStyle(fontSize: 16),
           ),
           subTitle: Text("Broj prestalih stolova: ${element.tableNum}"),
         ),
       ),
     );
   },
 );
}