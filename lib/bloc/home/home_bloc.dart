import 'package:bloc/bloc.dart';
import 'package:news_flutter_application/bloc/home/home_event.dart';
import 'package:news_flutter_application/bloc/home/home_state.dart';
import 'package:news_flutter_application/data/repository/news_article_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final INewsArticleRepository _newsArticlesRepository =
      NewsArticleRepository();

  HomeBloc() : super(HomeInitState()) {
    on<HomeInitializeData>((event, emit) async {
      emit(HomeLoadingState());

      var newsList = await _newsArticlesRepository.getAllNewsArticles();

      emit(HomeRequestSuccessState(newsList));
    });
  }
}
