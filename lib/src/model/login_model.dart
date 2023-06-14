// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore_for_file: non_constant_identifier_names
@immutable
class LoginModel {
  final String email_id;
  final String password;

  const LoginModel({
    required this.email_id,
    required this.password,
  });

  LoginModel copyWith({
    String? email_id,
    String? password,
  }) {
    return LoginModel(
      email_id: email_id ?? this.email_id,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email_id': email_id,
      'password': password,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      email_id: map['email_id'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginModel(email_id: $email_id, password: $password)';

  @override
  bool operator ==(covariant LoginModel other) {
    if (identical(this, other)) return true;

    return other.email_id == email_id && other.password == password;
  }

  @override
  int get hashCode => email_id.hashCode ^ password.hashCode;
}

class LoginNotifier extends StateNotifier<LoginModel> {
  LoginNotifier() : super(const LoginModel(email_id: "", password: ''));

  void updateEmail(String value) {
    state = state.copyWith(email_id: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }
}
