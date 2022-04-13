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

class ComplicatedImageDemo extends StatelessWidget {
  const ComplicatedImageDemo({Key? key}) : super(key: key);

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

class MultipleItemDemo extends StatelessWidget {
  const MultipleItemDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterCarousel.builder(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: false,
          viewportFraction: 1,
          showIndicator: true,
          autoPlay: true,
          slideIndicator: CircularStaticIndicator(),
        ),
        itemCount: (imgList.length / 2).round(),
        itemBuilder: (context, index, realIdx) {
          final first = index * 2;
          final second = first + 1;
          return Row(
            children: [first, second].map((idx) {
              return Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    child: Image.network(
                      imgList[idx],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
