import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Posts extends Equatable {
  final String userId;
  final String id;
  final String title;
  final String body;

  const Posts({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [userId, id, title, body];
}
