import 'package:flutter/material.dart';

class ArticleSection extends StatelessWidget {
  const ArticleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String _loremIpsumParagraph =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
        'tempor incididunt ut labore et dolore magna aliqua. Vulputate dignissim '
        'suspendisse in est. Ut ornare lectus sit amet. Eget nunc lobortis mattis '
        'aliquam faucibus purus in. Hendrerit gravida rutrum quisque non tellus '
        'orci ac auctor. Mattis aliquam faucibus purus in massa. Tellus rutrum '
        'tellus pellentesque eu tincidunt tortor. Nunc eget lorem dolor sed. Nulla '
        'at volutpat diam ut venenatis tellus in metus. Tellus cras adipiscing enim '
        'eu turpis. Pretium fusce id velit ut tortor. Adipiscing enim eu turpis '
        'egestas pretium. Quis varius quam quisque id. Blandit aliquam etiam erat '
        'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
        'gravida rutrum quisque. Suspendisse in est ante in nibh mauris cursus '
        'mattis molestie. Adipiscing elit duis tristique sollicitudin nibh sit '
        'amet commodo nulla. Pretium viverra suspendisse potenti nullam ac tortor '
        'vitae.\n'
        '\n'
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
        'tempor incididunt ut labore et dolore magna aliqua. Vulputate dignissim '
        'suspendisse in est. Ut ornare lectus sit amet. Eget nunc lobortis mattis '
        'aliquam faucibus purus in. Hendrerit gravida rutrum quisque non tellus '
        'orci ac auctor. Mattis aliquam faucibus purus in massa. Tellus rutrum '
        'tellus pellentesque eu tincidunt tortor. Nunc eget lorem dolor sed. Nulla '
        'at volutpat diam ut venenatis tellus in metus. Tellus cras adipiscing enim '
        'eu turpis. Pretium fusce id velit ut tortor. Adipiscing enim eu turpis '
        'egestas pretium. Quis varius quam quisque id. Blandit aliquam etiam erat '
        'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
        'gravida rutrum quisque. Suspendisse in est ante in nibh mauris cursus '
        'mattis molestie. Adipiscing elit duis tristique sollicitudin nibh sit '
        'amet commodo nulla. Pretium viverra suspendisse potenti nullam ac tortor '
        'vitae';
    return Scaffold(
      appBar: AppBar(),
      body: const Text(_loremIpsumParagraph),
    );
  }
}
