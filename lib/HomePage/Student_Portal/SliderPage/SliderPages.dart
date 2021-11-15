import 'package:flutter/material.dart';
//import 'package:payment_app/Pages/LoginPage.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderScreen extends StatefulWidget {
  SliderScreen({Key? key}) : super(key: key);

  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  int currentPage = 0;
  List splashData = [
    "assets/images/school_ads_1.jpeg",
    "assets/images/school_ads_2.jpeg",
    "assets/images/school_ads_3.jpeg",
    //"assets/images/slider_3.png"
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
      ),
      //carouselController: _controller,
      items: splashData
          .map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.87,
                child: Image.asset(
                  item,
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  // AnimatedContainer buildDot({int index}) {
  //   return AnimatedContainer(
  //     duration: Duration(milliseconds: 200),
  //     margin: EdgeInsets.only(right: 5),
  //     height: 10,
  //     width: currentPage == index ? 20 : 6,
  //     decoration: BoxDecoration(
  //       color: currentPage == index ? Color(0xFF4548F8) : Color(0xFFD8D8D8),
  //       borderRadius: BorderRadius.circular(3),
  //     ),
  //   );
  // }
}
