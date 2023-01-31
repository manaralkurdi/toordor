part of 'locale_cubit.dart';

//اذا كان يوجد Class واحدة ما في داعي لل Abstract class

// @immutable
// abstract class LocaleState {}
//
// class LocaleInitial extends LocaleState {}

class ChangeLanguageState {
  final Locale locale;
  ChangeLanguageState({required this.locale});
}
