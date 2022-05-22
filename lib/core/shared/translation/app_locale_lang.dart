
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class   AppLocaleLang {

  Locale locale ;

 AppLocaleLang( this.locale) ;

 late Map<String , String> _loadedLocalizedValues ;

  static AppLocaleLang of (BuildContext context) {
    return Localizations.of(context, AppLocaleLang) ;
  }

  Future loadLang() async {
    String  _langFile = await rootBundle.loadString('assets/lang/${locale.languageCode}.json') ;
    Map<String ,dynamic> _loadedValues = jsonDecode(_langFile);
    _loadedLocalizedValues = _loadedValues.map((key, value) => MapEntry(key, value.toString())) ;
  }

  String? getTranslated (String key) {
    return _loadedLocalizedValues[key] ;
  }

  static const LocalizationsDelegate<AppLocaleLang> delegate  = _AppLocalDelegate() ;

}


class  _AppLocalDelegate extends LocalizationsDelegate<AppLocaleLang> {
  const _AppLocalDelegate() ;
  @override
  bool isSupported(Locale locale) {
    return ["en" , "ar"].contains(locale.languageCode) ;
  }

  @override
  Future<AppLocaleLang> load(Locale locale) async {
    AppLocaleLang appLocale = AppLocaleLang(locale) ;
    await appLocale.loadLang();
    return appLocale ;
  }

  @override
  bool shouldReload(_AppLocalDelegate  old) => false  ;

}


getLang(BuildContext context  , String key) {
  return AppLocaleLang.of(context).getTranslated(key) ;
}



// extension Translation on String {
//   String get key => null;
//
//   String? tr() => AppLocaleLang.of(context).getTranslated(key);
// }

// String translate(String key, [Map<String, String>? arguments]) {
//   String value = (_values == null || _values![key] == null) ? key : _values![key];
//   if (arguments == null) return value;
//   for (var key in arguments.keys) {
//     value = value.replaceAll(key, arguments[key]!);
//   }
//   return value;
// }
