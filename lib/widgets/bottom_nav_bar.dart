import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app_with_firebase/pages/categories_page.dart';
import 'package:news_app_with_firebase/pages/home_page.dart';
import 'package:news_app_with_firebase/pages/notifications_page.dart';
import 'package:news_app_with_firebase/pages/profile_page.dart';
import 'package:news_app_with_firebase/pages/saved_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 2;
  static const List<Widget> _widgetOptions = <Widget>[
    SavedPage(),
    CategoriesPage(),
    HomePage(),
    NotificationsPage(),
    ProfilePage(),
  ];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

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
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          //animationCurve: Curves.easeInOut,
          animationCurve: Curves.elasticOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _widgetOptions[_page],
              ],
            ),
          ),
        ));
  }
}
