import 'package:news_flutter_application/data/datasource/news_article_datasource.dart';
import 'package:news_flutter_application/data/models/news_article.dart';

abstract class INewsArticleRepository {
  Future<List<NewsArticle>> getAllNewsArticles();
}

class NewsArticleRepository extends INewsArticleRepository {
  final INewsArticleDatasource _newsArticleDatasource = NewsArticleRemoteDatasource();

  @override
  Future<List<NewsArticle>> getAllNewsArticles() async {
    var response = await _newsArticleDatasource.getAllNewsArticles();
    return response;
  }
}
