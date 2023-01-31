abstract class SendRequestState {}

class SendRequestInitial extends SendRequestState {}

class SendRequestLoading extends SendRequestState {}

class SendRequestSuccess extends SendRequestState {
  // Model Model;
  // Success(this.Model);
}

class SendRequestError extends SendRequestState {
  final String error;

  SendRequestError(this.error);
}
