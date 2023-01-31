import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription ?subscription;

  InternetBloc() : super(InternetInitial()) {
    on<InternetConnection>((event, emit) {
      emit(Connection("Connected"));
    });
    on<NoInternetConnection>((event, emit) {
      emit(NoConnection("NotConnected"));
    });
    subscription = Connectivity().onConnectivityChanged.listen((event) {(
        ConnectivityResult result ){
      print(result);
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetConnection());
      } else {
        add(NoInternetConnection());
      }
    };
    });

  }
@override
Future <void >close() {
  subscription!.cancel();
 return super.close();
}

}
