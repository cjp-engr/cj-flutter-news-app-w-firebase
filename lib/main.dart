import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/blocs/auth/auth_bloc.dart';
import 'package:news_app_with_firebase/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:news_app_with_firebase/blocs/saved_news/saved_news_bloc.dart';
import 'package:news_app_with_firebase/blocs/signin/signin_cubit.dart';
import 'package:news_app_with_firebase/blocs/signup/signup_cubit.dart';
import 'package:news_app_with_firebase/firebase_options.dart';
import 'package:news_app_with_firebase/pages/home_page.dart';
import 'package:news_app_with_firebase/pages/signin_page.dart';
import 'package:news_app_with_firebase/pages/signup_page.dart';
import 'package:news_app_with_firebase/pages/splash_page.dart';
import 'package:news_app_with_firebase/repositories/auth_repository.dart';
import 'package:news_app_with_firebase/repositories/news_repository.dart';
import 'package:news_app_with_firebase/services/news_api_services.dart';
import 'package:news_app_with_firebase/widgets/bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    timeDilation = 3;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NewsRepository(
            newsApiServices: NewsApiServices(
              httpClient: http.Client(),
            ),
          ),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
      ],
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
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
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
          home: const SplashPage(),
          routes: {
            SignupPage.routeName: (context) => const SignupPage(),
            SigninPage.routeName: (context) => const SigninPage(),
            HomePage.routeName: (context) => const HomePage(),
            BottomNavBar.routeName: (context) => BottomNavBar(),
          },
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
