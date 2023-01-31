
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toordor/view/block/cach_helper.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLanguageState> {
  LocaleCubit() : super(ChangeLanguageState(locale: const Locale('ar')));

  Future<void> getSavedLanguage()async{
    final String codeLanguage=await LanguageCacheHelper().getCachedLanguageCode();
    emit(ChangeLanguageState(locale: Locale(codeLanguage)));
  }

  Future<void>changeLanguage(String lang)async{
    await  LanguageCacheHelper().cacheLanguageCode(lang);
    emit(ChangeLanguageState(locale: Locale(lang)));

  }
}

