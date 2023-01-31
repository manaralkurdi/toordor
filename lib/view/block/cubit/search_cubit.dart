import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../const/new_url_links.dart';
import '../../../model/search_model.dart';
import '../../../network/remote/api_request.dart';
import 'package:toordor/view/block/state/Search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  Future<void> search({
    String? mobileNumber,
  }) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    emit(SearchLoading());
    ApiRequest.postData(data: {
      "phone": mobileNumber,
    }, path: ApiLinks.search, token: _token)
        .then((value) {
          print(value.data.toString());
      if (value.data['success'] == true) {
        print(value);
        SearchModel search = SearchModel.fromJson(value.data);
        emit(SearchSuccess(search));
      }
      else{
        emit(SearchError("الرجاء ادخال رقم الهاتف للبحث ".tr()));
      }
    }).catchError((Error) {
      emit(SearchError("الرجاء التحقق من البيانات".tr()));
    });
  }
}
