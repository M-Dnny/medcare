// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore_for_file: non_constant_identifier_names

class SignupModel {
  final String fullname;
  final String email_id;
  final String password;
  final String phone_number;

  SignupModel({
    required this.fullname,
    required this.email_id,
    required this.password,
    required this.phone_number,
  });

  SignupModel copyWith({
    String? fullname,
    String? email_id,
    String? password,
    String? phone_number,
  }) {
    return SignupModel(
      fullname: fullname ?? this.fullname,
      email_id: email_id ?? this.email_id,
      password: password ?? this.password,
      phone_number: phone_number ?? this.phone_number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullname': fullname,
      'email_id': email_id,
      'password': password,
      'phone_number': phone_number,
    };
  }

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel(
      fullname: map['fullname'] as String,
      email_id: map['email_id'] as String,
      password: map['password'] as String,
      phone_number: map['phone_number'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupModel.fromJson(String source) =>
      SignupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignupModel(fullname: $fullname, email_id: $email_id, password: $password, phone_number: $phone_number)';
  }

  @override
  bool operator ==(covariant SignupModel other) {
    if (identical(this, other)) return true;

    return other.fullname == fullname &&
        other.email_id == email_id &&
        other.password == password &&
        other.phone_number == phone_number;
  }

  @override
  int get hashCode {
    return fullname.hashCode ^
        email_id.hashCode ^
        password.hashCode ^
        phone_number.hashCode;
  }
}

class SignupNotifier extends StateNotifier<SignupModel> {
  SignupNotifier()
      : super(SignupModel(
            email_id: "", password: '', fullname: "", phone_number: ""));

  void updateEmail(String value) {
    state = state.copyWith(email_id: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void updateFullname(String value) {
    state = state.copyWith(fullname: value);
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(phone_number: value);
  }
}
