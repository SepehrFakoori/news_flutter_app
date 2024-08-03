import 'package:news_flutter_application/data/models/news_article.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  List<NewsArticle> newsArticlesList;

  HomeRequestSuccessState(this.newsArticlesList);
}
