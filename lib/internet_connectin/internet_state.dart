part of 'internet_bloc.dart';

@immutable
abstract class InternetState {}

class InternetInitial extends InternetState {}
class Connection extends InternetState{
  String msg;
  Connection(this.msg);
}
class NoConnection extends InternetState{
  String msg;
  NoConnection(this.msg);
}