import 'package:news_flutter_application/data/models/news_article.dart';
import 'package:dio/dio.dart';

abstract class INewsArticleDatasource {
  Future<List<NewsArticle>> getAllNewsArticles();
}

class NewsArticleRemoteDatasource extends INewsArticleDatasource {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://newsapi.org/v2/"));

  @override
  Future<List<NewsArticle>> getAllNewsArticles() async {
    try {
      Map<String, String> qParams = {
        "country": "us",
        "apiKey": "0e1a9f5e3262471996da3b844254f764",
      };

      var response = await _dio.get('top-headlines',
          queryParameters: qParams);

      return response.data["articles"]
          .map<NewsArticle>(
              (jsonObject) => NewsArticle.fromMapJson(jsonObject))
          .toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
