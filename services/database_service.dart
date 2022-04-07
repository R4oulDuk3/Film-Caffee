
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_caffe_aplikacija/models/EventReservationList.dart';
import 'package:film_caffe_aplikacija/models/Reservation.dart';
import 'package:film_caffe_aplikacija/models/SpecialOffer.dart';
import 'package:film_caffe_aplikacija/models/Table.dart';
import 'package:film_caffe_aplikacija/models/email.dart';
import 'package:film_caffe_aplikacija/models/event.dart';
import 'package:film_caffe_aplikacija/screens/info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
class DatabaseService {
  late Event? event;
  final firestore = FirebaseFirestore.instance;
  DatabaseService({this.event});
  Stream<List<Email>> get adminEmails {
    return firestore.collection("adminEmailList").snapshots().map(
        (_emailListFromSnapshot));
  }
  List <Email> _emailListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Email.fromMap(doc.data() as Map<String,dynamic>);
    }).toList();
  }
  List <TableCaffe> _tableListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      var table = TableCaffe.fromMap(doc.data() as Map<String,dynamic>);
      table.tableId=doc.id;
      return table;
    }).toList();
  }
  List <String> _adminUidFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return doc["userId"] as String;}).toList();
  }
  List<TablesLayout> _tablesLayoutFromSnapsoht(QuerySnapshot snapshot){
    return snapshot.docs.map(
        (doc){
          List<TableCaffe> tables =[];
          firestore.collection("tableLayouts").doc(doc.id).
          collection("Tables").get().then(
                  (value){
                    value.docs.forEach(
                            (doc) {
                             // print(doc.id);
                              tables.add(TableCaffe.fromMap(doc.data())
                              );
                            });
                  }
          );

          return TablesLayout(
              name: doc['name'],
              tables: tables,
              desc:doc['desc']);
        }
    ).toList();
  }
  Stream<List<TablesLayout>> get tablesLayout{
    return firestore.collection("tableLayouts").snapshots().map(_tablesLayoutFromSnapsoht);
  }
  Stream<List<String>> get adminUserId {
    return firestore.collection("adminUsers").snapshots().map(
        (_adminUidFromSnapshot));
  }
  Stream<List<TableCaffe>> get tableModles{
    return firestore.collection("tableModels").snapshots().map(
        (_tableListFromSnapshot));
  }
  List<FreeTable> _freeTablesFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return FreeTable(
          eventId: doc['eventId'],
          eventName: doc['eventName'],
          name: doc['name'],
          desc: doc['desc'],
          minNum: doc['minNum'],
          maxNum: doc['maxNum'],
          tableNum: doc['amount'],
          tableId: doc.id);
     // list.add(table);
    }).toList();
  }

  Stream<List<FreeTable>> get freeTablesOneEvent{
    return firestore.collection("freeTables").where("eventId",isEqualTo: event!.id).
    snapshots().map(_freeTablesFromSnapshot);
  }

  List<Event> _eventListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Event(
          name: doc["name"],
          imgURL: doc["imgURL"],
          description: doc["description"],
          date: DateTime.parse((doc["date_time"]as Timestamp).toDate().toString()),
          id: doc.id,
      );
    }
    ).toList();
  }
  List<PendingReservation> _pendingReservationListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return PendingReservation(
          eventId: doc['eventId'],
        eventName: doc['eventName'],
        userId: doc["userId"],
        tableName: doc["tableName"],
        desc: doc["reservationDesc"],
        time: DateTime.parse((doc["time"]as Timestamp).toDate().toString()),
        id: doc.id,
        amountOfPeople: doc["amountOfPeople"],
        tablDesc: doc["tableDesc"],
        tableId: doc["tableId"]

        /*
          * 'userId':userId,
            'tableName':table.name,
            'tableDesc':table.desc,
            'reservationDesc': desc,
            'num':amountOfPeople,
            'time':Timestamp.fromDate(DateTime.now())*/
      );
    }
    ).toList();  }
  List<ApprovedReservation> _approvedReservationListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return ApprovedReservation(
          userId: doc["userId"],
          tableName: doc["tableName"],
          desc: doc["reservationDesc"],
          time: DateTime.parse((doc["time"]as Timestamp).toDate().toString()),
          id: doc.id,
          amountOfPeople: doc["amountOfPeople"],
          tablDesc: doc["tableDesc"],
          eventId: doc['eventId'],
          eventName: doc['eventName']
        /*
          * 'userId':userId,
            'tableName':table.name,
            'tableDesc':table.desc,
            'reservationDesc': desc,
            'num':amountOfPeople,
            'time':Timestamp.fromDate(DateTime.now())*/
      );
    }
    ).toList();  }
  List<SpecialOffer> _SpecialOfferFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return SpecialOffer(
          name: doc['name'],
          desc: doc['desc'],
        requiredAmount: doc['requiredAmount'],
        imgUrl: doc['imgUrl']

      );
    }
    ).toList();  }

  Stream<List<SpecialOffer>>get specialOffers{

    return firestore.collection("specialOffers").snapshots().map(_SpecialOfferFromSnapshot);
  }

  Stream<List<Event>>get events{

    return firestore.collection("Events").snapshots().map(_eventListFromSnapshot);
  }

  Stream<List<FreeTable>>get freeTables{
    return firestore.collection("freeTables").snapshots().map(_freeTablesFromSnapshot);
  }
  Stream<List<ApprovedReservation>>get approvedReservations{
    return firestore.collection("approvedReservations").snapshots().map(_approvedReservationListFromSnapshot);
  }
  Stream<List<PendingReservation>>get pendingReservations{
    return firestore.collection("pendingReservations").snapshots().map(_pendingReservationListFromSnapshot);
  }


  Future<String> addEvent(Event event)async{
    try{
      DocumentReference docRef= await firestore.collection("Events").add(
      {
        'name': event.name,
        'imgURL' : event.imgURL,
        'date_time' : Timestamp.fromDate(event.date),
        'description':event.description,
      }
    );
      print("Dodat dogadjaj");
      return docRef.id;
    }
    catch(e){
      print(e.toString());
      return "Error";
    }
  }
  Future deleteEvent(Event event)async{
    try{
      //print("RESERVATION ID:"+ event.idRezervacije!);
      await firestore.collection("Events").doc(event.id).delete();
      print("Obrisan!");

      firestore.collection('freeTables').where("eventId",isEqualTo: event.id).get().
      then((snapshot){
        for (DocumentSnapshot ds in snapshot.docs)
          ds.reference.delete();
      });
      firestore.collection('pendingReservations').where("eventId",isEqualTo: event.id).get().
      then((snapshot){
        for (DocumentSnapshot ds in snapshot.docs)
          ds.reference.delete();
      });
      firestore.collection('approvedReservations').where("eventId",isEqualTo: event.id).get().
      then((snapshot){
        for (DocumentSnapshot ds in snapshot.docs)
          ds.reference.delete();
      });
     /* deleteCollection(firestore.collection("eventReservations").doc(event.idRezervacije)
          .collection('approvedReservations'));
      deleteCollection(firestore.collection("eventReservations").doc(event.idRezervacije)
          .collection('pendingReservations'));*/
      await firestore.collection("eventReservations").doc(event.idRezervacije).delete();
      print("Obrisan!");
      return;
    }catch(e){
      print(e.toString());
    }
  }

  Future<String> deleteFromCollectionWhere(CollectionReference<Map<String, dynamic>> collection)async{
    try{
      await collection.get().then(
              (snapshot) {
            for (DocumentSnapshot ds in snapshot.docs)
              ds.reference.delete();
          });
      return "Uspeh";
    }
    catch(e){
      return e.toString();
    }
  }

  Future updateEvent(Event e) async{
    try{
      print("ID: ");
      if(e.id!=null)print(e.id);
      await firestore.collection("Events").doc(e.id).set({
        'name': e.name,
        'imgURL' : e.imgURL,
        'date_time' : Timestamp.fromDate(e.date),
        'description':e.description
      });
      print("Azurirano!");
    }catch(e){
      print("ERROR: "+e.toString());
    }
  }
  Future <List<TableCaffe>> getFreeTables(String resId)async{
    List<TableCaffe> list=[];
    try{
      var snapshot =await firestore.collection("eventReservations").doc(resId)
          .collection("freeTables").get();

    for (DocumentSnapshot ds in snapshot.docs){
      var table = TableCaffe.fromMap(ds.data() as Map<String, dynamic>);
      table.tableId=ds.id;
      list.add(table);
    }

      return list;
    }
    catch(e){
      print(e.toString());
      return [];
    }
  }
  Future<String> addPendingReservation(Event event,TableCaffe table,
      String userId,int amountOfPeople,String desc)async{
    try{
      if(table.tableNum!>1)
         await firestore.collection("freeTables").doc(table.tableId).update({
        'amount':(table.tableNum!-1)
      });
      if(table.tableNum!=null)table.tableNum=(table.tableNum!-1)!;
      await firestore.collection("pendingReservations").add(
          {
            'eventId':event.id,
            'eventName':event.name,
            'userId':userId,
            'tableName':table.name,
            'tableDesc':table.desc,
            'tableId':table.tableId,
            'reservationDesc': desc,
            'amountOfPeople':amountOfPeople,
            'time':Timestamp.fromDate(DateTime.now())
          }
      );

      print("Uspesan PENDING");
      return "Uspeh!";

    }catch(e){
      print(e.toString());
      return e.toString();
    }
  }
  Future<String> approvePendingReservation(PendingReservation pRes)async{
    try{
      await firestore.collection('approvedReservations').add(
        {
          'eventId':pRes.eventId,
          'eventName':pRes.eventName,
          'userId':pRes.userId,
          'tableName':pRes.tableName,
          'tableDesc':pRes.tablDesc,
          'reservationDesc': pRes.desc,
          'amountOfPeople':pRes.amountOfPeople,
          'time':Timestamp.fromDate(pRes.time)
        }
      );
      await firestore.collection('pendingReservations').doc(pRes.id).delete();
      print("Uspesno potvrdjena Rezervacija!");
      return "";
    }
    catch(e){
      print(e.toString());
      return e.toString();
    }
  }
  Future<String> denyPendingReservation(PendingReservation pRes) async{
    try{
      var docRef =await firestore.collection("freeTables").
      doc(pRes.tableId).get();

      int amountOfPeople=docRef.data()!['amount'];
      print("check");
      await firestore.collection("freeTables").doc(pRes.tableId).
      update({'amount':amountOfPeople+1});
      await firestore.collection("pendingReservations").
      doc(pRes.id).delete();
      print("Uspesan deny");
      return "Uspesan DENY";
    }catch(e){
      print(e.toString());
      return e.toString();
    }
  }


  Future<String> uploadFile(File _image) async {
    try {
      String result="";
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('chats/${Path.basename(_image.path)}}');
      UploadTask uploadTask = storageReference.putFile(File(_image.path));
      final snapshot = await uploadTask.whenComplete(() {});
      print('File Uploaded');

      result= await snapshot.ref.getDownloadURL();

      print(result);
      return result;
    }
    catch(e){
      print('ERROR: '+ e.toString());
      return e.toString();
    }
  }
  Future addTable(TableCaffe table)async{
    try{
      DocumentReference docRef= await firestore.collection("tableModels").add(
          {
            'name': table.name,
            'desc' : table.desc,
            'minNum' : table.minNum,
            'maxNum': table.maxNum
          }
      );
      /*await firestore.collection("Events").doc(docRef.id).collection(
          "SlobodniStolovi_"+docRef.id
      ).add({
        'test':'test123'
      });*/
      print("Uspeh!");
    }
    catch(e){
      print(e.toString());
    }
  }
  Future addTableLayout(TablesLayout layout)async{
    try{
      DocumentReference docRef= await firestore.collection("tableLayouts").add(
          {
            'name': layout.name,
            'desc' : layout.desc,
           // 'minNum' : table.minNum,
            //'maxNum': table.maxNum
          }
      );
      layout.tables.forEach((table) async {
        await firestore.collection("tableLayouts").doc(docRef.id).collection(
            "Tables"
        ).add(
          {
            'name': table.name,
            'desc' : table.desc,
            'minNum' : table.minNum,
            'maxNum': table.maxNum,
            'amount': table.tableNum
          }
        );
      });
      print("Uspeh!");
    }
    catch(e){
      print(e.toString());
    }
  }
  Future<String> addFreeTables(TablesLayout layout,Event event)async{
    print(layout.toString());
    try{

      layout.tables.forEach((table) async {
        print(table.toString()+" amount: ${table.tableNum}");
          await firestore.collection("freeTables").add(
              {
                'name': table.name,
                'desc' : table.desc,
                'minNum' : table.minNum,
                'maxNum': table.maxNum,
                'amount' : table.tableNum,
                'eventName' : event.name,
                'eventId':event.id
                //'amount': table.tableNum
              }
          );
      });
      print("Uspeh!");
      return "Uspeh";
    }
    catch(e){
      print(e.toString());
      return "Error";
    }
  }
  Future<String> addSpecialOffer(SpecialOffer specialOffer)async{
    try{
      DocumentReference docRef= await firestore.collection("SpecialOffers").add(
          {
            'name': specialOffer.name,
            'imgURL' : specialOffer.imgUrl,
            'description':specialOffer.desc,
            'requiredAmount':specialOffer.requiredAmount
          }
      );
      print("Dodata Akcija");
      return docRef.id;
    }
    catch(e){
      print(e.toString());
      return "Error";
    }
  }
  Future<String> deleteSpecialOffer(SpecialOffer specialOffer)async{
    try{
      await firestore.collection("SpecialOffers").
      doc(specialOffer.id).delete();
      return "Uspeh";
    }
    catch(e){
      print(e.toString());
      return "Error";
    }
  }

}



  /*

    List<EventReservationList> _eventReservationListFromSnapshot(QuerySnapshot snapshot){
    List<EventReservationList> list=[];
    snapshot.docs.forEach((doc) async {
      List<TableCaffe> freeTables= await firestore.collection("eventReservations").doc(doc.id).
        collection("freeTables").get().then(_freeTablesFromSnapshot);
      List<Reservation> pendingReservations= await firestore.collection("eventReservations").doc(doc.id).
      collection("pendingReservations").get().then(_reservationListFromSnapshot);
      List<Reservation> confirmedReservations= await firestore.collection("eventReservations").doc(doc.id).
      collection("approvedReservations").get().then(_reservationListFromSnapshot);
      list.add( EventReservationList(
          name: doc['name'],
          freeTables: freeTables,
          pendingReservations: pendingReservations,
          confirmedReservations: confirmedReservations));
    });
    return list;
    }
  * Future<List<Email>> getAdminEmails() async{
    try {
      QuerySnapshot querySnapshot = await firestore.collection("adminEmail")
          .get();
      var list = querySnapshot.docs;
      List<Email> retList = [];
      list.forEach((element) {
        retList.add(Email.fromMap(element.data() as Map<String, dynamic>));
      });
      return retList;
    }catch (e){
      print(e.toString());
      return [];
    }
}
  *
  * */