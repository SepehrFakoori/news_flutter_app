import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter_application/bloc/home/home_bloc.dart';
import 'package:news_flutter_application/bloc/home/home_event.dart';
import 'package:news_flutter_application/screens/home_screen.dart';
import 'package:news_flutter_application/screens/news_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) {
          var homeBloc = HomeBloc();
          homeBloc.add(HomeInitializeData());
          return homeBloc;
        },
        child: const HomeScreen(),
      ),
    );
  }
}
