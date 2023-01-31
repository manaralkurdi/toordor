import 'package:toordor/model/search_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  SearchModel searchModel;
  SearchSuccess(this.searchModel);
}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}
