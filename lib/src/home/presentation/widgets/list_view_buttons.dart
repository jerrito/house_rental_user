import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/src/home/presentation/widgets/row_buttons.dart';

class HouseCategories extends StatelessWidget {
  const HouseCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return   CarouselSlider.builder(
                          itemCount: 5,
                          options: CarouselOptions(
                            
                            viewportFraction: 0.3,
                            height: 50,
                            reverse: true,
                          ),
                          itemBuilder: (context, index, value) {
                            List<bool> isSelected = [
                              true,
                              false,
                              false,
                              true,
                              false
                            ];
                            return  RowButtons(
                              isSelected: isSelected[index],
                              label: "House",
                            );
                          });
  }
}
