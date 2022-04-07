import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/models/Table.dart';
import 'package:film_caffe_aplikacija/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:film_caffe_aplikacija/models/event.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class ReservationCreator extends StatefulWidget {
  const ReservationCreator({Key? key,required this.event}) : super(key: key);
  final Event event;
  @override
  _ReservationCreatorState createState() => _ReservationCreatorState();
}

class _ReservationCreatorState extends State<ReservationCreator> {
  TableCaffe? pickedTable=null;
  int? amountOfPeople=null;
  int pageNum=1;
  String desc="";
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder<List<TableCaffe>>(
      stream: DatabaseService(event: widget.event).freeTablesOneEvent,
      builder: (context,snapshot){
        if(snapshot.hasData){
          List<TableCaffe>? list = snapshot.data;
          //list!.forEach((element) {print(element);});
          //print("Broj slobodnih mesta " +list.length.toString());
          int i=0;
          while(list!.length==0||i!=list!.length){
            if(list[i].tableNum==0){
              list.removeAt(i);
            }
            else i++;
          }
          list!.sort((a,b){
            if(a.minNum==b.minNum)return 0;
            if(a.minNum>b.minNum) return -1;
            return 1;
          });
      return Container(
        height: screenHeight*(3.0/5),
        child: SingleChildScrollView(
          child: Center(
            child: pageNum==1?Column(
              children: [
                GFListTile(
                  color: Colors.grey,
                  avatar: GFAvatar(
                    backgroundImage: Image.network(widget.event.imgURL).image,
                    shape: GFAvatarShape.circle,
                  ),
                  title: Text(widget.event.name),
                  subTitle: Text(widget.event.date.toString()),
                ),
                Center(child: Text("Slobodni stolovi",style: naslovStil,)),
                Wrap(
                  alignment: WrapAlignment.center,
                  //crossAxisAlignment: WrapCrossAlignment.center,
                  children: list!.map(
                          (table){
                            if(table==pickedTable) {
                              return _buildChip(table, Colors.orange);
                            }
                            return _buildChip(table, Colors.blue);
                      }
                  ).toList(),
                  spacing: 6.0,
                  runSpacing: 6.0,
                ),
                Divider(),
                Text("Odabrani sto je: " + (pickedTable!=null?
                pickedTable.toString():"")),
                Divider(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GFIconButton(

                    icon: Icon(Icons.arrow_forward,color:Colors.white),
                    onPressed:pickedTable!=null? (){
                      setState(() {
                        pageNum=2;
                      });
                    }:null,
                    //text:"Potvrdi odabrani sto",
                    shape: GFIconButtonShape.circle,
                    color: Colors.black,
                    size: GFSize.LARGE,
                  ),
                )
              ],
            ):
            Column(
              children: [
                GFListTile(
                  color: Colors.grey,
                  avatar: GFAvatar(
                    backgroundImage: Image.network(widget.event.imgURL).image,
                    shape: GFAvatarShape.circle,
                  ),
                  title: Text(widget.event.name),
                  subTitle: Text(widget.event.date.toString()),
                ),
                Center(child: Text("Odaberite broj osoba",style: naslovStil,)),
                Container(
                  height: 50,
                  child: DropdownButtonHideUnderline(
                    child: GFDropdown(
                      padding: const EdgeInsets.all(15),
                      borderRadius: BorderRadius.circular(5),
                      border: const BorderSide(
                          color: Colors.black12, width: 1),
                      dropdownButtonColor: Colors.white,
                      value: amountOfPeople,
                      onChanged: (newValue) {
                        setState(() {
                          amountOfPeople = newValue as int;
                        });
                      },
                      items: pickedTable!.amountOfPeople()
                          .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.toString() +
                            (value==1?" osoba":" osobe")
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                ),
                Divider(),
                TextField(
                  decoration: decoration.copyWith(
                    hintText: "Imate li neki zahtev za lokal?"
                  ),
                  maxLines: 2,
                  onChanged: (val){
                    setState(() {
                      desc=val;
                    });
                  },
                ),
                Divider(),
                GFButton(
                    onPressed: () async {
                      await DatabaseService().addPendingReservation
                        (widget.event, pickedTable!, user!.uid, amountOfPeople!, desc);

                    },
                  text: "Pošalji zahtev za rezervaciju",
                  textStyle: dugmeStil.copyWith(
                    color: Colors.white
                  ),
                  size: GFSize.LARGE,
                  icon: Icon(Icons.email
                  ,color: Colors.white,)
                ),
                Divider(),
                GFIconButton(
                  color: Colors.black,
                  icon: Icon(Icons.arrow_back
                  ,color:Colors.white),
                    onPressed: (){
                  setState(() {
                    pageNum=1;
                  });
                    },
                shape: GFIconButtonShape.circle,
                size: GFSize.LARGE,
                ),

              ],
            ),
          ),
        )
      );}else
          return Container(
            height: screenHeight/2,

          );
      }
    );
  }
  Widget _buildChip(TableCaffe table, Color color) {
    return ActionChip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(table.name[0].toUpperCase()),
      ),
      label: Text(
        table.toString(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
      onPressed: () {
        setState(() {
          if(pickedTable==table)pickedTable=null;
          else pickedTable=table;
          amountOfPeople=table.minNum;
        });
      },
    );
  }
}

/*
* widget.event.layout.tables.map,*/
