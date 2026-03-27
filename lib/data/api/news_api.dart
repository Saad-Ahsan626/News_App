import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsApi {
  final String _apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
  final String _baseUrl = "https://newsapi.org";

  Future<Map<String, dynamic>> getNews({List<String> categories = const []}) async {
    String query = 'pakistan';
    if (categories.isNotEmpty) {
      String cats = categories.join(' OR ');
      query += ' AND ($cats)';
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/v2/everything?q=${Uri.encodeComponent(query)}&language=en&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load news');
    }
  }
}
