class SignInModel{
  late String message;
  late bool status;
  UserData ?date;

  SignInModel.fromJson(Map<String,dynamic>response){
    message=response['message'];
    status=response['status'];
    date=response['data']!=null?UserData.fromJson(response['data']):null;
  }
}

class UserData{
  late String name;
  late String email;
  late String phone;
  late int id;
  late String token;
  late String image;
  UserData.fromJson(Map<String,dynamic>data){
    id=data['id'];
    phone=data['phone'];
    name=data['name'];
    email=data['email'];
    image=data['image'];
    token=data['token'];
  }
}