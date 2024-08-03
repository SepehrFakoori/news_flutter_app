import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_flutter_application/data/models/news_article.dart';

class NewsScreen extends StatefulWidget {
  NewsArticle newsArticle;

  NewsScreen(this.newsArticle, {super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  toolbarHeight: 70,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.7),
                            ),
                            child: ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                              child: const Icon(Icons.shopping_cart_outlined),
                            ),
                          ),
                          const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.7),
                            ),
                            child: ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                              child: const Icon(Icons.shopping_cart_outlined),
                            ),
                          ),
                          const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(20),
                    child: Container(
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                      child: const Center(
                        child: Text("Sliver App Bar"),
                      ),
                    ),
                  ),
                  expandedHeight: 300,
                  pinned: true,
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      "assets/images/news_image.jpg",
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 20, bottom: 100),
                    child: Text(widget.newsArticle.description.toString()),
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
}
