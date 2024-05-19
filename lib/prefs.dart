import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<void> setGenre(List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('genre', list);
  }

  static Future<List<String>?> getGenre() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('genre');
  }

}