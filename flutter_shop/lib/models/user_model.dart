import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Users extends Equatable {
  final String id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  const Users({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        phone,
        website,
      ];
}
