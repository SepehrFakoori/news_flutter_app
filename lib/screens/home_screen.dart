import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter_application/bloc/home/home_bloc.dart';
import 'package:news_flutter_application/bloc/home/home_event.dart';
import 'package:news_flutter_application/bloc/home/home_state.dart';
import 'package:news_flutter_application/data/models/news_article.dart';
import 'package:news_flutter_application/screens/news_screen.dart';
import 'package:news_flutter_application/util/extension/string_extension.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(viewportFraction: 0.92, initialPage: 3);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (state is HomeRequestSuccessState) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(HomeInitializeData());
              },
              child: SafeArea(
                child: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(
                          child: _GetTagRow("Breaking News"),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 210,
                                child: PageView.builder(
                                  controller: controller,
                                  itemCount: state.newsArticlesList.length,
                                  itemBuilder: (context, index) => _SliderView(
                                      state.newsArticlesList[index]!),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SmoothPageIndicator(
                                controller: controller,
                                count: state.newsArticlesList.length,
                                effect: const ExpandingDotsEffect(
                                  spacing: 5.0,
                                  expansionFactor: 3,
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  dotColor: Colors.grey,
                                  activeDotColor: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: _GetTagRow("Recommendations"),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: state.newsArticlesList.length,
                            (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child:
                                  CardContainer(state.newsArticlesList[index]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.01),
                              Colors.white.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox(
            width: 1,
            height: 1,
          );
        },
      ),
    );
  }
}

class _SliderView extends StatelessWidget {
  NewsArticle newsArticle;

  _SliderView(
    this.newsArticle, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 210,
              child: newsArticle.urlToImage == null
                  ? Image.asset(
                      'assets/images/news_image.jpg',
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: newsArticle.urlToImage!,
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          Positioned(
            left: 20,
            top: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blueAccent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 4,
                    ),
                    child: Center(
                      child: Text(
                        newsArticle.name!.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      newsArticle.name.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.blueAccent,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      newsArticle.publishedAt!.toCustomFormat(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _GetTagRow extends StatelessWidget {
  final String tagName;

  const _GetTagRow(this.tagName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            tagName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
            child: const Text("View All"),
          ),
        ],
      ),
    );
  }
}

class CardContainer extends StatefulWidget {
  NewsArticle newsArticle;

  CardContainer(this.newsArticle, {super.key});

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewsScreen(widget.newsArticle)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                width: 140,
                height: 140,
                child: widget.newsArticle.urlToImage == null
                    ? Image.asset(
                        "assets/images/news_image.jpg",
                        fit: BoxFit.fill,
                      )
                    : CachedNetworkImage(
                        imageUrl: widget.newsArticle.urlToImage!,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    widget.newsArticle.name!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      widget.newsArticle.title!.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.newsArticle.publishedAt!.toCustomFormat(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
