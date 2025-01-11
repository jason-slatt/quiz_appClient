import 'dart:convert';

import 'package:flutter/foundation.dart';

class User{
  late final String? id;
  late final String name;
  late final String email;
  late final String password;
  late final String? token;
  late final String? type;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.token,
    this.type


  });

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map["_id"] ?? '' ,
    name: map["name"] ?? '',
    email: map["email"] ?? '',
    password: map["password"] ?? '',
    token: map["token"] ?? '',
    type: map["type"] ?? '',


  );
  factory User.fromJson(Map<String,dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'] ?? '',
      email: json['  email'] ?? '',
      password: json["password"] ?? '',
      token: json["token"] ?? '',
      type: json["type"] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email" : email,
    "password": password,
    "token" : token,
    "type" : type

  };


  String toJson() => json.encode(toMap());
// factory User.fromJson(String str) => User.fromMap(json.decode(str));

}



