import 'package:flutter/material.dart';
import 'package:news_app/data/repositories/article_repository.dart';

class ArticleProvider with ChangeNotifier {
  final ArticleRepository repo = ArticleRepository();

  List _articles = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List get articles => _articles;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future getNews() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _articles = await repo.getNews();
    } catch (e) {
      _errorMessage = 'Could not fetch news. Please check your connection.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
