import 'package:localize_and_translate/localize_and_translate.dart';

import '../../helper/local/cache_helper.dart';
import '../../utils/constants.dart';

class TranslateLang {
  static Future translatorInit() async => await translator.init(
      localeType: LocalizationDefaultType.device,
      languagesList: <String>[langAR, langEN],
      assetsDirectory: 'assets/lang/',
      language: currentLang ?? langAR);

  static void changeLang(context) async {
    await translator.setNewLanguage(
      context,
      newLanguage: translator.activeLanguageCode == langAR ? langEN : langAR,
      remember: true,
      restart: true,
    );

    CacheHelper.saveData(
      key: CURRENT_LANG_KEY,
      value: translator.activeLanguageCode,
    );

    print(translator.activeLanguageCode);
  }

  static String langApi() {
    if (translator.activeLanguageCode == langAR) {
      return 'ar-EG';
    } else if (translator.activeLanguageCode == langEN) {
      return 'en-US';
    } else {
      return 'ar-EG';
    }
  }
}
