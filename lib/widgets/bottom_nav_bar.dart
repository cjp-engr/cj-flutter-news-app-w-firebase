import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_firebase/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/pages/categories_page.dart';
import 'package:news_app_with_firebase/pages/home_page.dart';
import 'package:news_app_with_firebase/pages/weather_page.dart';
import 'package:news_app_with_firebase/pages/profile_page.dart';
import 'package:news_app_with_firebase/pages/saved_page.dart';

class BottomNavBar extends StatelessWidget {
  static const String routeName = '/bottomnav';
  final int _page = 2;
  static const List<Widget> _widgetOptions = <Widget>[
    SavedPage(),
    CategoriesPage(),
    HomePage(),
    WeatherPage(),
    ProfilePage(),
  ];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        height: 75.0,
        items: <Widget>[
          Icon(
            Icons.bookmark,
            size: 40,
            color: themeLightColor1,
          ),
          Icon(
            Icons.category,
            size: 40,
            color: themeLightColor1,
          ),
          Icon(
            Icons.house,
            size: 40,
            color: themeLightColor1,
          ),
          Icon(
            Icons.wb_sunny,
            size: 40,
            color: themeLightColor1,
          ),
          Icon(
            Icons.person,
            size: 40,
            color: themeLightColor1,
          ),
        ],
        color: themeLightColor2,
        buttonBackgroundColor: themeLightColor3,
        backgroundColor: themeLightColor3,
        //animationCurve: Curves.easeInOut,
        animationCurve: Curves.elasticOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          context.read<BottomNavBarBloc>().add(SetPageEvent(index: index));
        },
        letIndexChange: (index) => true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
              builder: (context, state) {
                return _widgetOptions[state.currentIndex];
              },
            )
          ],
        ),
      ),
    );
  }
}
