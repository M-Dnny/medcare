// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class ForgotPasswordModel {
  final String email;

  const ForgotPasswordModel({
    required this.email,
  });

  ForgotPasswordModel copyWith({
    String? email,
  }) {
    return ForgotPasswordModel(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory ForgotPasswordModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordModel(
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordModel.fromJson(String source) =>
      ForgotPasswordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ForgotPasswordModel(email: $email)';

  @override
  bool operator ==(covariant ForgotPasswordModel other) {
    if (identical(this, other)) return true;

    return other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordModel> {
  ForgotPasswordNotifier() : super(const ForgotPasswordModel(email: ""));

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }
}
