import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SwipperViewProd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: [
        Image.asset('assets/photo1.png', fit: BoxFit.cover),
        Image.asset('assets/photo2.png', fit: BoxFit.cover),
        Image.asset('assets/photo3.png', fit: BoxFit.cover),
      ],
    );
  }
}
