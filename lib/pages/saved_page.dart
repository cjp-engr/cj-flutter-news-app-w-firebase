import 'package:flutter/material.dart';
import 'package:news_app_with_firebase/widgets/savedpage/saved_news.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Welcome back, Carmen'),
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
