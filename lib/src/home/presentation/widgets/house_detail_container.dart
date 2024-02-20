// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';

class HouseDetailContainer extends StatelessWidget {
  final void Function()? favouriteOnTap, arrowBackOnTap;
  final num? bedRoomCount, bathhRoomCount;
  final String? houseIMageURL, description, houseName;
  const HouseDetailContainer({
    Key? key,
    required this.arrowBackOnTap,
    required this.favouriteOnTap,
    this.bedRoomCount,
    this.bathhRoomCount,
    this.houseIMageURL,
    this.description,
    this.houseName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:Sizes().height(context, 0.34),
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(22.0),
                child: Container(
                  height: Sizes().height(context, 0.34),
                  width: double.infinity,
                  decoration: BoxDecoration(gradient: houseContainerGradient),
                  child: Image.network(
                    houseIMageURL ?? "",
                    height: Sizes().height(context, 0.34),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    //opacity: const AlwaysStoppedAnimation(.8),
                  ),
                )
                //child: ,
                ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  right: 20,
                ),
                child: GestureDetector(
                  onTap: favouriteOnTap,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: houseContainerRowColor,
                    child:
                        SvgPicture.asset(bookMarkSVG, color: houseWhiteColor),
                  ),
                ),
              )),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 10,
                ),
                child: GestureDetector(
                  onTap: arrowBackOnTap,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: houseContainerRowColor,
                    child: SvgPicture.asset(
                      arrowBackSVG,
                    ),
                  ),
                ),
              )),
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  bottom: 16,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       houseName ?? "House",
                        style: appTheme.textTheme.displayLarge!.copyWith(
                            color: houseWhiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                       description ?? "",
                        style: appTheme.textTheme.displaySmall!.copyWith(
                            color: searchTextColor3,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: houseContainerRowColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: SvgPicture.asset(bedSVG,
                                  color: houseWhiteColor)),
                           Space().width(context, 0.02),
                           Text(
                            "$bedRoomCount BedRoom",
                            style:const TextStyle(
                              color: houseWhiteColor,
                            ),
                          ),
                          Space().width(context, 0.03),
                          Container(
                              decoration: BoxDecoration(
                                  color: houseContainerRowColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: SvgPicture.asset(bathSVG,
                                  color: houseWhiteColor)),
                           Space().width(context, 0.02),        
                           Text(
                            "$bathhRoomCount BathRoom",
                            style:const TextStyle(
                              color: houseWhiteColor,
                            ),
                          )
                        ],
                      )
                    ]),
              ))
        ],
      ),
    );
  }
}
