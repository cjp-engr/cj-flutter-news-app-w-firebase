import 'package:flutter/material.dart';

class NewsTitle extends StatelessWidget {
  const NewsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget title(String? title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
