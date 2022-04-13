import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

final List<String> imgList = [
  'https://source.unsplash.com/random/1920x1920/?abstracts',
  'https://source.unsplash.com/random/1920x1920/?fruits,flowers',
  'https://source.unsplash.com/random/1080x640/?sports',
  'https://source.unsplash.com/random/1920x1920/?nature',
  'https://source.unsplash.com/random/1920x1920/?science',
  'https://source.unsplash.com/random/1920x1920/?computer'
];

class LatestNews extends StatelessWidget {
  const LatestNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.width,
      ),
      child: FlutterCarousel(
        options: CarouselOptions(
          autoPlay: true,
        ),
        items: imgList
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    child: Image.network(
                      item,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext ctx, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (
                        BuildContext context,
                        Object exception,
                        StackTrace? stackTrace,
                      ) {
                        return const Text(
                          'Oops!! An error occurred. 😢',
                          style: TextStyle(fontSize: 16.0),
                        );
                      },
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
