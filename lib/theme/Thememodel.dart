// ignore_for_file: file_names

import 'package:deliveryboy/theme/Theme_share_pref.dart';
import 'package:flutter/widgets.dart';

class Thememodel extends ChangeNotifier {
  late bool _isdark;
  late Themesharedprefrences themesharedprefrences;
  bool get isDark => _isdark;

  Thememodel() {
    _isdark = false;
    themesharedprefrences = Themesharedprefrences();
    getThemeprefrences();
  }

  set isdark(bool value) {
    _isdark = value;
    themesharedprefrences.setTheme(value);
    notifyListeners();
  }

  getThemeprefrences() async {
    _isdark = await themesharedprefrences.getTheme();
    notifyListeners();
  }
}
