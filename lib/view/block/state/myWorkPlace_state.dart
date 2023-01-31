// MyWorkPlace

abstract class MyWorkPlaceState {}

class MyWorkPlaceInitial extends MyWorkPlaceState {}

class MyWorkPlaceCancelRequestLoading extends MyWorkPlaceState {}

class MyWorkPlaceCancelRequestSuccess extends MyWorkPlaceState {
  // MyWorkPlaceModel MyWorkPlaceModel;
  // MyWorkPlaceSuccess(this.MyWorkPlaceModel);
}

class MyWorkPlaceCancelRequestError extends MyWorkPlaceState {
  final String error;

  MyWorkPlaceCancelRequestError(this.error);
}

// class MyWorkPlaceSendRequestLoading extends MyWorkPlaceState {}

// class MyWorkPlaceSendRequestSuccess extends MyWorkPlaceState {
//   // MyWorkPlaceModel MyWorkPlaceModel;
//   // MyWorkPlaceSuccess(this.MyWorkPlaceModel);
// }

// class MyWorkPlaceSendRequestError extends MyWorkPlaceState {
//   final String error;

//   MyWorkPlaceSendRequestError(this.error);
// }

class MyWorkPlaceAcceptRequestLoading extends MyWorkPlaceState {}

class MyWorkPlaceAcceptRequestSuccess extends MyWorkPlaceState {
  // MyWorkPlaceModel MyWorkPlaceModel;
  // MyWorkPlaceSuccess(this.MyWorkPlaceModel);
}

class MyWorkPlaceAcceptRequestError extends MyWorkPlaceState {
  final String error;

  MyWorkPlaceAcceptRequestError(this.error);
}
