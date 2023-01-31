abstract class HomeState {}

class HomeInitial extends HomeState {}

class LocationServiceState extends HomeState {}

class LocationDeniedState extends HomeState {}

class LocationForeverState extends HomeState {}

class GetLocationSuccessState extends HomeState {}

class SearchLoadingState extends HomeState {}

class SearchSuccessState extends HomeState {}

class SearchErrorState extends HomeState {
  final String error;

  SearchErrorState(this.error);
}
