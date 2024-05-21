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

  static Future<void> setLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale);
  }

  static Future<String?> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('locale');
  }
}