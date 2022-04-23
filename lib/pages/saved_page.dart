import 'package:flutter/material.dart';

import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/widgets/savedpage/saved_news.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Saved News',
            style: TextStyle(color: themeLightColor1),
          ),
        ),
        body: Column(
          children: const [
            SavedNews(),
          ],
        ),
      ),
    );
  }
}
