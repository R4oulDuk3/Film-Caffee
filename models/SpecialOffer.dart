
class SpecialOffer{
  String name,desc;
  int requiredAmount;
  late String? id;
  SpecialOffer({required this.name,required this.desc,
    required this.requiredAmount,required this.imgUrl,this.id});
  String imgUrl;
}

class UserSpecialOfferCard{

  SpecialOffer specialOffer;
  int currentAmount;
  int idUser;late String? id;
  UserSpecialOfferCard({required this.specialOffer,required this.currentAmount,
  required this.idUser,this.id});
}