import 'package:shared_preferences/shared_preferences.dart';

void logout(){
  SharedPreferences.getInstance().then((prefs) {
    prefs.clear();
  });
}