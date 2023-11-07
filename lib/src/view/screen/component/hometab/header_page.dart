import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HeaderPage extends StatelessWidget {
  List<String> listImage =  [
    // 'https://www.pexels.com/photo/yellow-and-black-leather-cross-body-bag-2002717/',
    // 'https://www.efasheen.com/wp-content/uploads/2020/12/Pantone-Colors.png',
    'https://img.freepik.com/free-photo/woman-wearing-pink-dress-holding-shopping-bags_329181-9167.jpg?size=626&ext=jpg&ga=GA1.1.292346486.1699017504&semt=sph',
    'https://img.freepik.com/free-photo/attractive-woman-with-shopping-bags_329181-8877.jpg?size=626&ext=jpg&ga=GA1.1.292346486.1699017504&semt=sph',
    'https://img.freepik.com/premium-photo/indian-family-celebrating-diwali-deepavali-traditional-wear-with-shopping-bags-standing-isolated-white-background_466689-45149.jpg?size=626&ext=jpg&ga=GA1.1.292346486.1699017504&semt=sph',
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 300,
          viewportFraction: 1.0,
          autoPlay: true,
          enlargeCenterPage: false,
        // autoPlay: false,
      ),
      items: listImage.map((e) => Image.network(e,fit: BoxFit.cover,)).toList(),
    );
  }
}
