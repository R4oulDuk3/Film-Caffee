
class Email{
  final String email;

  Email({required this.email});
  factory Email.fromMap(Map data){
    return Email(email: data['email']??"error");
  }
  @override
  String toString() {

    return email;
  }

}