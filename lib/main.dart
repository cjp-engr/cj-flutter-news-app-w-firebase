import 'package:flutter/material.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:news_app_with_firebase/repositories/news_repository.dart';
import 'package:news_app_with_firebase/services/news_api_services.dart';
import 'package:news_app_with_firebase/widgets/bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NewsRepository(
        newsApiServices: NewsApiServices(
          httpClient: http.Client(),
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ActiveCategoryBloc>(
            create: (context) => ActiveCategoryBloc(
              newsRepository: RepositoryProvider.of<NewsRepository>(context),
            )..add(FetchLatestNewsEvent()),
          ),
          BlocProvider<BottomNavBarBloc>(
            create: (context) => BottomNavBarBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            //primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              button: TextStyle(
                fontSize: 20.0,
              ),
              headline5: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                fontSize: 26.5,
                fontWeight: FontWeight.bold,
              ),
              subtitle1: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
              subtitle2: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.w600,
              ),
              bodyText1: TextStyle(
                fontSize: 21.0,
              ),
              bodyText2: TextStyle(
                fontSize: 19.0,
              ),
              caption: TextStyle(
                fontSize: 15.0,
              ),
            ).apply(
              fontFamily: 'RobotoMono',
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                // padding: MaterialStateProperty.all(
                //   const EdgeInsets.symmetric(vertical: 15.0),
                // ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                elevation: MaterialStateProperty.all(10),
              ),
            ),
          ),
          //home: const MyHomePage(),
          home: BottomNavBar(),
        ),
      ),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
