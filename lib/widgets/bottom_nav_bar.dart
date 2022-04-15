import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app_with_firebase/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:news_app_with_firebase/pages/categories_page.dart';
import 'package:news_app_with_firebase/pages/home_page.dart';
import 'package:news_app_with_firebase/pages/notifications_page.dart';
import 'package:news_app_with_firebase/pages/profile_page.dart';
import 'package:news_app_with_firebase/pages/saved_page.dart';

class BottomNavBar extends StatelessWidget {
  final int _page = 2;
  static const List<Widget> _widgetOptions = <Widget>[
    SavedPage(),
    CategoriesPage(),
    HomePage(),
    NotificationsPage(),
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
        items: const <Widget>[
          FaIcon(FontAwesomeIcons.solidBookmark, size: 30),
          FaIcon(FontAwesomeIcons.box, size: 30),
          FaIcon(FontAwesomeIcons.houseChimneyUser, size: 30),
          FaIcon(FontAwesomeIcons.bellConcierge, size: 30),
          FaIcon(FontAwesomeIcons.userLarge, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.indigoAccent,
        backgroundColor: Colors.white,
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
