import 'package:flutter/material.dart';
import 'package:kawait/Shared%20preferences/shared_preferences.dart';

class ChangeStateOnBoardingNotifier extends ChangeNotifier {
  String state = AppSettingsPreferences().state;

  void changeState({required String state}) {
    this.state = state;
    AppSettingsPreferences().saveOnBoardingScreenState(state: state);
    notifyListeners();
  }
}
