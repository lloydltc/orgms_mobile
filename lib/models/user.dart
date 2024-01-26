import 'dart:convert';

class User{
  bool success;
  String token;
  int id;
  String firstName;
  String lastName;
  String email;
  String phone;

  // int id;
  // String email;
  // String phone;
  // String name;
  // String token;

  User({required this.success, required this.token, required this.id,required this.firstName, required this.lastName, required this.email, required this.phone});

  factory User.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return User(
      success: json['success'],
      token: json['token'],
      id :json['id'],
      firstName:json['firstName'],
      lastName : json['lastName'],
      email : json['email'],
      phone : json['phone'],
    );

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = new Map<String, dynamic>();
    user['success'] = this.success;
    user['token'] = this.token;
    user['email'] = this.email;
    user['phone'] = this.phone;
    return user;
  }

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }

}

