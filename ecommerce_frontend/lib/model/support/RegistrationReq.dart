import '../object/User.dart';

class RegistrationReq{
  User user;
  String password;
  RegistrationReq({required this.user, required this.password});

  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'pass': password,
  };

  User getUser(){
    return user;
  }

}