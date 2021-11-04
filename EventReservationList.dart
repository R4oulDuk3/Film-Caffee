import 'package:film_caffe_aplikacija/models/Reservation.dart';
import 'package:film_caffe_aplikacija/models/Table.dart';

class EventReservationList{
  String name;
  List <TableCaffe> freeTables;
  List<Reservation> pendingReservations;
  List<Reservation> confirmedReservations;
  EventReservationList({required this.name,required this.freeTables,
    required this.pendingReservations,required this.confirmedReservations});
  @override
  String toString() {
    // TODO: implement toString
    String res = ""+name + "\n freeTables\n";
    freeTables.forEach((element) {
      res+="\n "+element.toString();
    });
    res+= "\n pending \n";
    pendingReservations.forEach((element) {
      res+="\n "+element.toString();
    });
    res+= "\n confirmed \n";
    confirmedReservations.forEach((element) {
      res+="\n "+element.toString();
    });
    return res;
  }
}