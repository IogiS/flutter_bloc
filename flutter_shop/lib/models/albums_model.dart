import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Albums extends Equatable {
  final String userId;
  final String id;
  final String title;

  const Albums({
    required this.userId,
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [userId, id, title];
}
