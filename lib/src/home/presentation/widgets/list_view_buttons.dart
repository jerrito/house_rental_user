import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/src/home/presentation/widgets/row_buttons.dart';

class HouseCategories extends StatelessWidget {
  final bool isSelected;
  const HouseCategories({super.key,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: 5,
        options: CarouselOptions(
          viewportFraction: 0.3,
          height: 50,
          reverse: true,
        ),
        itemBuilder: (context, index, value) {
          return RowButtons(
            onTap: () {},
            isSelected: isSelected,
            label: category[index],
          );
        });
  }
}

List<String> category = [
  "house",
  "hotel",
  "apartment",
  "single room",
  "chamber and hall"
];
