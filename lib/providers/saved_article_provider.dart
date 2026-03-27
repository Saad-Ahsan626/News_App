import 'dart:convert';
import 'package:flutter/material.dart';
import '../data/models/article_model.dart';
import '../services/preferences_service.dart';

class SavedArticleProvider with ChangeNotifier {
  final PreferencesService _prefs = PreferencesService();
  List<Article> _savedArticles = [];

  List<Article> get savedArticles => _savedArticles;

  SavedArticleProvider() {
    loadSaved();
  }

  Future<void> loadSaved() async {
    try {
      final savedStrings = await _prefs.getBookmarks();
      List<Article> parsed = [];
      for (var str in savedStrings) {
        try {
          parsed.add(Article.fromJson(json.decode(str)));
        } catch (e) {
          debugPrint('Error parsing saved article: $e');
        }
      }
      _savedArticles = parsed;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading bookmarks: $e');
    }
  }

  bool isSaved(String url) {
    if (url.isEmpty) return false;
    return _savedArticles.any((article) => article.url == url);
  }

  Future<void> toggleSaved(Article article) async {
    if (article.url.isEmpty) return;
    
    if (isSaved(article.url)) {
      _savedArticles.removeWhere((a) => a.url == article.url);
    } else {
      _savedArticles.add(article);
    }
    
    final savedStrings = _savedArticles.map((a) => json.encode(a.toJson())).toList();
    await _prefs.saveBookmarks(savedStrings);
    notifyListeners();
  }
}
