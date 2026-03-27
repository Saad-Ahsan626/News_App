import 'package:flutter/material.dart';
import 'package:news_app/data/repositories/article_repository.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/services/preferences_service.dart';

class ArticleProvider with ChangeNotifier {
  final ArticleRepository repo = ArticleRepository();
  final PreferencesService _prefs = PreferencesService();

  List<Article> _articles = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> loadNews() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final interests = await _prefs.getInterests();
      _articles = await repo.getNews(interests);
    } catch (e) {
      _errorMessage = 'Could not fetch news. Please check your connection.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
