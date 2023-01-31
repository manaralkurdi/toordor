// service

import 'package:toordor/model/services_modle.d'
    'art';

abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesEmployeesLoading extends ServicesState {}

class ServicesEmployeesSuccess extends ServicesState {
  ServiceModelEmployee ServicesEmployeesData;
  ServicesEmployeesSuccess(this.ServicesEmployeesData);
}

class ServicesEmployeesError extends ServicesState {
  final String error;

  ServicesEmployeesError(this.error);
}

class ServicesIndexLoading extends ServicesState {}

class ServicesIndexSuccess extends ServicesState {
  ServicesIndexSuccess();
}

class ServicesIndexError extends ServicesState {
  final String error;

  ServicesIndexError(this.error);
}