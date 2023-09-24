import 'package:kawait/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsPreferences {
  AppSettingsPreferences._internal();

  late SharedPreferences _sharedPreferences;

  static final AppSettingsPreferences _instance =
      AppSettingsPreferences._internal();

  factory AppSettingsPreferences() {
    return _instance;
  }

  Future<void> intiPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveOnBoardingScreenState({required String state}) async {
    await _sharedPreferences.setString('state', state);
  }

  String get state => _sharedPreferences.getString('state') ?? "0";

  /******************************************************/

  Future<void> saveUser({required UserData user}) async {
    _sharedPreferences.setString('id', user.id ?? "");
    _sharedPreferences.setString('username', user.name ?? "");
    _sharedPreferences.setString('email', user.email ?? "");
    _sharedPreferences.setString('mobileNumber', user.phone ?? "");
    _sharedPreferences.setString('imageURL', user.imageURL ?? "");
    _sharedPreferences.setString('address', user.address ?? "");
    _sharedPreferences.setString('companyName', user.companyName ?? "");
  }

  UserData user() {
    UserData user = new UserData(
        id: _sharedPreferences.getString('id')!,
        name: _sharedPreferences.getString('username')!,
        email: _sharedPreferences.getString('email')!,
        companyName: _sharedPreferences.getString('companyName'),
        address: _sharedPreferences.getString('address')!,
        imageURL: _sharedPreferences.getString('imageURL')!,
        phone: _sharedPreferences.getString('mobileNumber')!);

    return user;
  }

  Future<void> updateLoggedIn() async {
    print(_sharedPreferences.getString('token'));
    await _sharedPreferences.setString('token', '');
    await _sharedPreferences.setString('id', '');
    print(_sharedPreferences.getString('token'));
  }

  String get id => _sharedPreferences.getString('id') ?? '';
  String get email => _sharedPreferences.getString('email') ?? '';

  void handleClearPrefs() {
    _sharedPreferences.clear();
    print("true");
  }
}
