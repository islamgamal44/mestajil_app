import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/langauge_manger.dart';

const String PREF_KEY_LANG = "PREF_KEY_LANG";
const String PREF_KEY_ONBOARDING_SCREEN_VIEW =
    "PREF_KEY_ONBOARDING_SCREEN_VIEW";
const String PREF_KEY_IS_USER_LOGGED_IN = "PREF_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREF_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      //return default lang
      return LanguageType.ENGLISH.getValue();
    }
  }

  // ON BOARDING
  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREF_KEY_ONBOARDING_SCREEN_VIEW, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREF_KEY_ONBOARDING_SCREEN_VIEW) ?? false;
  }

  // login
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREF_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREF_KEY_IS_USER_LOGGED_IN) ?? false;
  }
}
