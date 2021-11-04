import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/HeroDialogRoute.dart';
import 'package:film_caffe_aplikacija/Widgets/TableCreator.dart';
import 'package:film_caffe_aplikacija/Widgets/TablesLayoutCreator.dart';
import 'package:film_caffe_aplikacija/Widgets/drawer.dart';
import 'package:film_caffe_aplikacija/models/Table.dart';
import 'package:film_caffe_aplikacija/screens/CreatorCard.dart';
import 'package:film_caffe_aplikacija/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TableManagerScreen extends StatefulWidget {
  TableManagerScreen({Key? key, required this.adminMode}) : super(key: key);
  final bool adminMode;
  @override
  _TableManagerScreenState createState() => _TableManagerScreenState();
}

class _TableManagerScreenState extends State<TableManagerScreen> {
  int pageIndex=0;
  bool visible=true;
  @override
  Widget build(BuildContext context) {


    void _showSettingsPanel() {
      showModalBottomSheet(
        isScrollControlled: true,
          context: context,
          builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: TableCreator()

        );
      });
    }
    List<TableCaffe>tableModles = Provider.of<List<TableCaffe>?>(context)??[];
    List<Widget> tables =[
      Text("Tipovi stolova:",style: naslovStil,)
    ];
    tableModles.forEach((element) {
      tables.add(TableListTile(table: element,));
    });
    List<TablesLayout> layouts = Provider.of<List<TablesLayout>?>(context)??[];
    if(layouts!=null)
      layouts.forEach((element) { print(element.toString());});
    List<Widget>tableLayouts=[Text("Stolovi Postavke:",style: naslovStil,)];
    if(layouts!=null)
      layouts.forEach((layout) {
        tableLayouts.add(TablesLayoutListTile(layout: layout));
      });

    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: NavigationDrawerWidget(adminMode:widget.adminMode),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("Stolovi",
              style: naslovStil
          ),

        ),
        body: Container(
          width: double.infinity,
          color: Colors.purple,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AnimatedOpacity(
                opacity: visible?1.0:0.0,
                duration: Duration(milliseconds: 250),
                child: ListView(

                  children: pageIndex==0?tables:tableLayouts,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.purple,
        color: Colors.white,
        items: <Widget>[
          Icon(Icons.arrow_back, size: 30,color: Colors.black,),
          Icon(Icons.arrow_forward, size: 30,color: Colors.black,),
          //Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) async {
          if(index == pageIndex)return;
          setState(() {
            visible=false;
          });
          await Future.delayed(Duration(milliseconds: 500));
          setState(() {
            pageIndex=index;
          });
          setState(() {
            visible=true;
          });
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: "table",
          onPressed: (){
            //_showSettingsPanel();
              Navigator.of(context).push(HeroDialogRoute(builder:
                (context){
                  return CreatorCard(content:
                  pageIndex==0?TableCreator():
                  TablesLayoutCreator(),
                  heroTag: "table",);
                  },
                )
              );
          },
          backgroundColor: Colors.white,
          child: Icon(Icons.add,color: Colors.black,)
        ),

    );

  }
}


