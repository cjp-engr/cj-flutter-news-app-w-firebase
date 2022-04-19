import 'package:flutter/material.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:news_app_with_firebase/blocs/saved_news/saved_news_bloc.dart';
import 'package:news_app_with_firebase/repositories/news_repository.dart';
import 'package:news_app_with_firebase/services/news_api_services.dart';
import 'package:news_app_with_firebase/widgets/bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    timeDilation = 3;
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
          BlocProvider<SavedNewsBloc>(
            create: (context) => SavedNewsBloc(
              activeCategoryBloc: BlocProvider.of<ActiveCategoryBloc>(context),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            cardTheme: const CardTheme(
              elevation: 10,
            ),
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
                fontWeight: FontWeight.bold,
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
                fontSize: 19.0,
              ),
            ).apply(
              fontFamily: 'ABeeZee',
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.resolveWith<Color>(
                //   (Set<MaterialState> states) {
                //     if (states.contains(MaterialState.pressed)) {
                //       return Theme.of(context)
                //           .colorScheme
                //           .primary
                //           .withOpacity(0.5);
                //     } else if (states.contains(MaterialState.disabled)) {
                //       return Theme.of(context)
                //           .colorScheme
                //           .primary
                //           .withOpacity(0.5);
                //     }
                //     return Theme.of(context)
                //         .colorScheme
                //         .primary
                //         .withOpacity(0.5);
                //   },
                // ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
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
