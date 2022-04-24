import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../blocs/blocs.dart';
import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/firebase_options.dart';
import 'package:news_app_with_firebase/pages/home_page.dart';
import 'package:news_app_with_firebase/pages/signin_page.dart';
import 'package:news_app_with_firebase/pages/signup_page.dart';
import 'package:news_app_with_firebase/pages/splash_page.dart';
import 'package:news_app_with_firebase/repositories/auth_repository.dart';
import 'package:news_app_with_firebase/repositories/news_repository.dart';
import 'package:news_app_with_firebase/repositories/profile_repository.dart';
import 'package:news_app_with_firebase/repositories/saved_news_repository.dart';
import 'package:news_app_with_firebase/repositories/weather_repository.dart';
import 'package:news_app_with_firebase/services/news_api_services.dart';
import 'package:news_app_with_firebase/services/weather_api_services.dart';
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
        RepositoryProvider(
          create: (context) => WeatherRepository(
            weatherApiServices: WeatherApiServices(
              httpClient: http.Client(),
            ),
          ),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<SavedNewsRepository>(
          create: (context) => SavedNewsRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<BottomNavBarBloc>(
            create: (context) => BottomNavBarBloc(
              signinCubit: BlocProvider.of<SigninCubit>(context),
            ),
          ),
          BlocProvider<ActiveCategoryBloc>(
            create: (context) => ActiveCategoryBloc(
              newsRepository: RepositoryProvider.of<NewsRepository>(context),
              signinCubit: BlocProvider.of<SigninCubit>(context),
            )..add(FetchInitialNewsEvent()),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),
          BlocProvider<SearchNewsBloc>(
            create: (context) => SearchNewsBloc(
              newsRepository: RepositoryProvider.of<NewsRepository>(context),
            ),
          ),
          BlocProvider<SavedNewsBloc>(
            create: (context) => SavedNewsBloc(
              savedNewsRepository:
                  RepositoryProvider.of<SavedNewsRepository>(context),
              signinCubit: BlocProvider.of<SigninCubit>(context),
            )..add(FetchSavedNewsEvent()),
          ),
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<TempSettingsBloc>(
            create: (context) => TempSettingsBloc(),
          ),
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider<FontSizeBloc>(
            create: (context) => FontSizeBloc(),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            Color _getThemeColor(bool isThemeLight) {
              if (isThemeLight) {
                return themeLightColor1;
              } else {
                return themeLightColor4;
              }
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: (state.isThemeLightSwitch == true
                      ? ThemeData.light()
                      : ThemeData.dark())
                  .copyWith(
                iconTheme: IconThemeData(
                  color: _getThemeColor(state.isThemeLightSwitch),
                ),
                cardTheme: const CardTheme(
                  elevation: 20,
                ),
                switchTheme: SwitchThemeData(
                  thumbColor: MaterialStateProperty.all(
                    _getThemeColor(!state.isThemeLightSwitch),
                  ),
                ),
                sliderTheme: SliderThemeData(
                  activeTrackColor: _getThemeColor(!state.isThemeLightSwitch),
                  thumbColor: _getThemeColor(!state.isThemeLightSwitch),
                ),
                appBarTheme: AppBarTheme(
                  backgroundColor: themeLightColor2,
                  elevation: 20,
                  actionsIconTheme: IconThemeData(
                    color: themeLightColor1,
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: themeLightColor2,
                    ),
                  ),
                  filled: true,
                  floatingLabelStyle: TextStyle(
                    color: themeLightColor2,
                  ),
                  iconColor: themeLightColor2,
                ),
                textTheme: TextTheme(
                  button: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: _getThemeColor(!state.isThemeLightSwitch),
                  ),
                  headline5: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                    color: _getThemeColor(!state.isThemeLightSwitch),
                  ),
                  headline6: TextStyle(
                    fontSize: 26.5,
                    fontWeight: FontWeight.w600,
                    color: _getThemeColor(!state.isThemeLightSwitch),
                  ),
                  subtitle1: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                    color: _getThemeColor(!state.isThemeLightSwitch),
                  ),
                  subtitle2: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w600,
                    color: _getThemeColor(!state.isThemeLightSwitch),
                  ),
                  bodyText1: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w300,
                    color: _getThemeColor(!state.isThemeLightSwitch),
                  ),
                  bodyText2: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w300,
                    color: _getThemeColor(!state.isThemeLightSwitch),
                  ),
                  caption: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w300,
                    color: _getThemeColor(!state.isThemeLightSwitch),
                  ),
                ).apply(
                  fontFamily: 'Poppins',
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(themeLightColor2),
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
            );
          },
        ),
      ),
    );
  }
}
