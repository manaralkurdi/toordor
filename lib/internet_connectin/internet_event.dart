part of 'internet_bloc.dart';


abstract class InternetEvent {}

class InternetConnection extends InternetEvent{
}
class NoInternetConnection extends InternetEvent{
}