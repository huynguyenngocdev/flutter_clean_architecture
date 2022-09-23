import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'pref/app_pref.dart';
import 'pref/pref_helper.dart';

@injectable
class AppStorage {
  static const _prefsBox = 'prefs';

  AppStorage._();

  static AppStorage init() {
    if (!(Hive.isBoxOpen(_prefsBox))) {
      Hive.openBox(_prefsBox);
    }
    return AppStorage._();
  }

  PrefHelper get prefHelper => AppPrefs(prefBox: Hive.box(_prefsBox));
}
