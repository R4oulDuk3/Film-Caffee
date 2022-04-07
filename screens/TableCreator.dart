import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/models/Table.dart';
import 'package:film_caffe_aplikacija/services/database_service.dart';
import 'package:flutter/material.dart';
class TableCreator extends StatefulWidget {
  const TableCreator({Key? key}) : super(key: key);

  @override
  _TableCreatorState createState() => _TableCreatorState();
}

class _TableCreatorState extends State<TableCreator> {
  //Icon? icon = Icon(Icons.table);
  String name="";
  String desc="";
  int minNum=1,maxNum=1;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text("Novi Sto",
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
                hintText: "Opis stola",
                suffixIcon: Icon(Icons.update),
              ),
              //validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
              onChanged: (val){
                setState(() {
                  desc=val;
                });
              },
            ),
            Container(
              //width: MediaQuery.of(context).size.width-50,
              child: Row(
                children: [
                  Text("Minimalno gostiju"),Expanded(child: Container()),
                  minNum!=1?IconButton(onPressed: (){
                    setState(() {
                      if(minNum>1)
                        minNum-=1;
                    });
                  }, icon: Icon(Icons.remove),)
                      :Container(),
                  Text(minNum.toString()),
                  IconButton(onPressed: (){
                    setState(() {
                      minNum+=1;
                      if(minNum>maxNum)maxNum=minNum;
                    });
                  }, icon: Icon(Icons.add),)
                ],
              ),
            ),
            Container(
              //width: MediaQuery.of(context).size.width-50,
              child: Row(
                children: [
                  Text("Maximalno gostiju"),Expanded(child: Container()),
                  maxNum!=1?IconButton(onPressed: (){
                    setState(() {
                      if(maxNum>1) maxNum-=1;
                      if(minNum>maxNum)minNum=maxNum;
                    });
                  }, icon: Icon(Icons.remove),)
                      :Container(),
                  Text(maxNum.toString()),
                  IconButton(onPressed: (){
                    setState(() {
                      maxNum+=1;
                    });
                  }, icon: Icon(Icons.add),)
                ],
              ),
            ),
            Center(child:
            RaisedButton(
              onPressed: ()async{
                if(_formKey.currentState!.validate()) {
                  TableCaffe table = TableCaffe(
                      name: name,
                      desc: desc,
                      minNum: minNum,
                      maxNum: maxNum
                  );
                  await DatabaseService().addTable(table);
                }
              },
              child: Text("Dodaj sto"),
            ),)
          ],
        ),
      );

  }
}