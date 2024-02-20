import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/core/size/sizes.dart';

class GalleryRow extends StatelessWidget {
  final int itemCount;
  final List<String> image;
  const GalleryRow({super.key, required this.itemCount, required this.image});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: itemCount,
        options:
            CarouselOptions(
              enableInfiniteScroll:itemCount <=4? false:true,
              height:Sizes().height(context, 0.11),
              viewportFraction: 0.3),
        itemBuilder: (context, index, value) {
          return Padding(
            padding:  EdgeInsets.symmetric(
             horizontal: Sizes().width(context, 0.01 )),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                 image[index],
                  width: Sizes().width(context, 0.32),
                  height: Sizes().height(context, 0.11),
                  fit: BoxFit.cover,
                )),
          );
        });
  }
}
