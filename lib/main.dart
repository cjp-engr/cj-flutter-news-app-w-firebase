import 'package:flutter/material.dart';
import 'package:news_app_with_firebase/services/news_api_services.dart';
import 'package:news_app_with_firebase/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          //primarySwatch: Colors.blue,
          ),
      //home: const MyHomePage(),
      home: const BottomNavBar(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // @override
  // void initState() {
  //   _getNews();
  //   super.initState();
  // }

  // void _getNews() {
  //   NewsApiServices a = NewsApiServices();
  //   a.getLatestNews();
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
