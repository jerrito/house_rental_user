import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental/assets/images/image_constants.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';

class HouseContainer extends StatelessWidget {
  final int? houseLength;
  final String? houseName, houseImage, houseSubName;
  final void Function()? onTap;
  const HouseContainer({
    super.key,
    required this.onTap,
    this.houseImage,
    this.houseLength,
    this.houseName,
    this.houseSubName,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: houseLength ?? 1,
        options: CarouselOptions(height: 272, viewportFraction: 0.6),
        itemBuilder: (context, index, value) {
          return GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: houseContainerGradient,
                  borderRadius: BorderRadius.circular(22.0),
                ),
                height: 272,
                width: 222,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(22.0),
                          child: Image.asset(
                           houseImage ?? house1Image,
                            height: 272,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            //opacity: const AlwaysStoppedAnimation(.3),
                          )

                          //child: ,
                          ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 25.0,
                            right: 12,
                          ),
                          child: Container(
                            width: 70,
                            decoration: BoxDecoration(
                              color: houseContainerRowColor,
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    locationSVG,
                                  ),
                                  const Text(
                                    "1.8 km",
                                    style: TextStyle(
                                      color: houseWhiteColor,
                                    ),
                                  )
                                ]),
                          ),
                        )),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            bottom: 16,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                houseName ??  "DreamsVille House",
                                  style:
                                      appTheme.textTheme.displayLarge!.copyWith(
                                    color: houseWhiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                 houseSubName ?? "Jl. Sultan Iskandar Muda",
                                  style: appTheme.textTheme.displaySmall!
                                      .copyWith(
                                          color: searchTextColor3,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                ),
                              ]),
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
