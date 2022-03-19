part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUser extends UserEvent {}

class LoadUserFailed extends UserEvent {}
