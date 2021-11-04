
import 'package:flutter/material.dart';
class TableCaffe{
  final String name;
  final String desc;
  final int minNum,maxNum;
  late String? tableId;
  late int ?tableNum=0;
  TableCaffe({required this.name,required this.desc,
    required this.minNum,required this.maxNum,this.tableNum,
  this.tableId});
  factory TableCaffe.fromMap(Map data){
    return TableCaffe(
        name: data['name']??"error",
      desc: data['desc']??"error",
      minNum: data['minNum']??-1,
      maxNum: data['maxNum']??-1,
        tableNum: data['amount']??0,
    );
  }
  List<int> amountOfPeople(){
    List<int> list = [];
    for(int i =minNum;i<=maxNum;i++){
      list.add(i);
    }
    return list;
  }
  @override
  String toString() {
    //  implement toString
    return name +" ("+(minNum!=maxNum?
    minNum.toString()+"-"+maxNum.toString():
    minNum.toString())+")";//+" "+(tableNum!=null?tableNum:-1).toString();
  }
  @override
  bool operator ==(Object other) {
    if(!(other is TableCaffe))return false;

    return this.tableId==other.tableId;
  }
}
class FreeTable extends TableCaffe{
  String eventId;
  String eventName;

  FreeTable({required this.eventId,
    required this.eventName,required String name,
    required String desc,
    required int minNum,required int maxNum,
    required String tableId,
  required int tableNum}) : super(
      name:name,
      desc:desc,
      minNum:minNum,
      maxNum:maxNum,
      tableId:tableId,
    tableNum: tableNum
  );

}
class TablesLayout{
  String name;
  String desc;
  late String tableLayoutId="";
  late List<TableCaffe> tables;
  TablesLayout({required this.name,required this.tables,required this.desc});
  @override
  String toString() {
    //  implement toString
    String s = name;
    tables.forEach((element) {s+="\n"+element.toString(); });
    return s;
  }
}
class TablesLayoutListTile extends StatefulWidget {
  TablesLayoutListTile({Key? key,required this.layout}) : super(key: key);
  TablesLayout layout;
  @override
  _TablesLayoutListTileState createState() => _TablesLayoutListTileState();
}

class _TablesLayoutListTileState extends State<TablesLayoutListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: ListTile(

        title: Text(widget.layout.name),
        subtitle: Text("Broj stolova: " +widget.layout.tables.length.toString())
        ),
      );
  }
}


class TableListTile extends StatefulWidget {
  TableListTile({required this.table});
  TableCaffe table;
  @override
  _TableListTileState createState() => _TableListTileState();
}

class _TableListTileState extends State<TableListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: ListTile(

        title: Text(widget.table.name),
        subtitle: Text("Broj osoba: " +
            (widget.table.minNum==widget.table.maxNum?widget.table.minNum.toString():
            "${widget.table.minNum}-${widget.table.maxNum}")
        ),
      ),
    );
  }
}

class TablePicker extends StatefulWidget {
  TablePicker({Key? key,required this.table}) : super(key: key);
  TableCaffe table;
  int getNum(){
    return table.tableNum??0;
  }

  @override
  _TablePickerState createState() => _TablePickerState();
}

class _TablePickerState extends State<TablePicker> {
  int num=0;
  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.black, width: 2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${widget.table.name} " +
                (widget.table.minNum==widget.table.maxNum?
            "${widget.table.minNum}":
            "${widget.table.minNum}-${widget.table.maxNum}"),),Expanded(child: Container()),
            num!=0?IconButton(onPressed: (){
              setState(() {
                if(num>0) num-=1;
                //if(num>ma)minNum=maxNum;
                widget.table.tableNum=num;
              });
            }, icon: Icon(Icons.remove),)
                :Container(),
            Text(num.toString()),
            IconButton(onPressed: (){
              setState(() {
                num+=1;
                widget.table.tableNum=num;
              });
            }, icon: Icon(Icons.add),)
          ],
        ),
      ),
    );
  }
}

