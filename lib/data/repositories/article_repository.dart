import '../api/news_api.dart';
import '../models/article_model.dart';

class ArticleRepository {
  final NewsApi _newsApi = NewsApi();

  Future<List> getNews() async {
    final data = await _newsApi.getNews();
    final List articlesJson = data['articles'];
    return articlesJson.map((json) => Article.fromJson(json)).toList();
  }
}
