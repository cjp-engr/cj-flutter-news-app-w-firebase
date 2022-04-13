import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

final List<String> imgList = [
  'https://source.unsplash.com/random/1920x1920/?abstracts',
  'https://source.unsplash.com/random/1920x1920/?fruits,flowers',
  'https://source.unsplash.com/random/1080x640/?sports',
  'https://source.unsplash.com/random/1920x1920/?nature',
  'https://source.unsplash.com/random/1920x1920/?science',
  'https://source.unsplash.com/random/1920x1920/?computer',
  'https://source.unsplash.com/random/1920x1920/?abstracts',
  'https://source.unsplash.com/random/1920x1920/?fruits,flowers',
  'https://source.unsplash.com/random/1080x640/?sports',
  'https://source.unsplash.com/random/1920x1920/?nature',
  'https://source.unsplash.com/random/1920x1920/?science',
  'https://source.unsplash.com/random/1920x1920/?computer',
];

class AroundTheWorld extends StatelessWidget {
  const AroundTheWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterCarousel.builder(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: false,
          viewportFraction: 1,
          showIndicator: false,
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
