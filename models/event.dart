
class Event{
  String name;
  String imgURL;
  DateTime date;
  String description;
  late String? id;
  late String? idRezervacije;
  //int brojMesta=100;
  Event({required this.imgURL,required this.description,
    required this.name,required this.date,this.id,this.idRezervacije});
@override
  String toString() {
  return "Dogadjaj "+name+" "+date.toString()+" "+(
    idRezervacije!=null?idRezervacije:"-").toString();

  }

}