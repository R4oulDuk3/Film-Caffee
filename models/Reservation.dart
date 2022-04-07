class Reservation{
  String userId, tableName, tablDesc, desc;
  int amountOfPeople;
  DateTime time;
  String id,eventId,eventName;
  Reservation({required this.userId,required this.desc,
    required this.amountOfPeople,required this.time,
    required this.tablDesc,required this.tableName,
    required this.id,required this.eventId,required this.eventName});

  @override
  String toString() {
    // TODO: implement toString
    return tableName+" "+ userId+" "+time.toString();
  }
}
class PendingReservation extends Reservation{
  String tableId;
  PendingReservation({required String userId,required String desc,
    required int amountOfPeople,required DateTime time,
    required String tablDesc,required String tableName,
    required String id,required String eventId,required String eventName,required this.tableId}) :
        super(
        userId: userId,
          amountOfPeople:amountOfPeople,
          tableName:tableName,
          tablDesc:tablDesc,
          desc:desc,
          time:time,
          id:id,
          eventId:eventId,
          eventName:eventName
      );
}
class ApprovedReservation extends Reservation{
  ApprovedReservation({required String userId,required String desc,
    required int amountOfPeople,required DateTime time,
    required String tablDesc,required String tableName,
    required String id,required String eventId,required String eventName}) :
        super(
          userId: userId,
          amountOfPeople:amountOfPeople,
          tableName:tableName,
          tablDesc:tablDesc,
          desc:desc,
          time:time,
          id:id,
          eventId:eventId,
          eventName:eventName
      );
}