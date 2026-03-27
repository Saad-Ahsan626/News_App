import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _interestsKey = 'selected_interests';
  static const String _savedKey = 'saved_articles';

  Future<void> saveInterests(List<String> interests) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_interestsKey, interests);
  }

  Future<List<String>> getInterests() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_interestsKey) ?? [];
  }

  Future<bool> hasSavedInterests() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_interestsKey);
  }

  Future<void> saveBookmarks(List<String> articlesJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_savedKey, articlesJson);
  }

  Future<List<String>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_savedKey) ?? [];
  }
}
