import '../api/news_api.dart';
import '../models/article_model.dart';

class ArticleRepository {
  final NewsApi _newsApi = NewsApi();

  Future<List<Article>> getNews(List<String> categories) async {
    final data = await _newsApi.getNews(categories: categories);
    final List articlesJson = data['articles'] ?? [];
    return articlesJson
        .map((json) => Article.fromJson(json))
        .where((article) => article.title != '[Removed]')
        .toList();
  }
}
