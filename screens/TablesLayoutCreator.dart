import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/models/Table.dart';
import 'package:film_caffe_aplikacija/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class TablesLayoutCreator extends StatefulWidget {
  const TablesLayoutCreator({Key? key}) : super(key: key);

  @override
  _TablesLayoutCreatorState createState() => _TablesLayoutCreatorState();
}

class _TablesLayoutCreatorState extends State<TablesLayoutCreator> {
  //Icon? icon = Icon(Icons.table);

  String name="";
  String desc="";
  //int minNum=1,maxNum=1;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<TableCaffe> tables = Provider.of<List<TableCaffe>?>(context)??[];
    List<TablePicker> tablePickers=[];
    tables.forEach((element) {
      tablePickers.add(TablePicker(table: element));
    });
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text("Novi Layout Stolova",
                style: naslovStil,),
            ),
            SizedBox(height: 15,),
            TextFormField(
              decoration: decoration.copyWith(
                hintText: "Ime stola",
                suffixIcon: Icon(Icons.update),
              ),
              validator: (val) => val!.isEmpty ? 'Uneti naziv stola' : null,
              onChanged: (val){
                setState(() {
                  name=val;
                });
              },
            ),
            TextFormField(
              decoration: decoration.copyWith(
                hintText: "Opis",
                suffixIcon: Icon(Icons.update),
              ),
              //validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
              onChanged: (val){
                setState(() {
                  desc=val;
                });
              },
            ),
          ]+tablePickers+[
            Center(child:
            RaisedButton(
              onPressed: ()async{
                if(_formKey.currentState!.validate()) {
                  bool anyTablesPicked=false;
                  List<TableCaffe> tableCollection=[];
                  tablePickers.forEach((element) {
                    if(element.table.tableNum!=0){
                      tableCollection.add(element.table);
                      anyTablesPicked=true;
                    }
                  });
                  if(anyTablesPicked){
                    TablesLayout layout=
                        TablesLayout(
                            name: name, tables: tableCollection,
                            desc: desc);
                    await DatabaseService().addTableLayout(layout);
                  }
                }
              },
              child: Text("Dodaj Stolove"),
            ),)
          ],
        ),
      ),
    );
  }
}