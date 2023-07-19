// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String username;
  final String email;
  final List<String> favorites;
  const UserModel({
    required this.username,
    required this.email,
    required this.favorites,
  });

  @override
  List<Object?> get props => [username, email, favorites];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'favorites': favorites,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      favorites: List<String>.from(map['favorites']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
