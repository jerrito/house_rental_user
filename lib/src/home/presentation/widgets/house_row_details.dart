import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental/assets/images/image_constants.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';

class HouseRowDetails extends StatelessWidget {
  final num? bedRoomCount, bathhRoomCount, amount;
  final String? houseIMageURL, houseName;
  final void Function()? onTap;
  const HouseRowDetails(
      {super.key,
      this.bedRoomCount,
      this.bathhRoomCount,
      this.amount,
      this.houseIMageURL,
      this.houseName,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
        child: Column(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        houseIMageURL ?? "",
                        fit: BoxFit.cover,
                        height: 80,
                        width: 100,
                        errorBuilder: (_, __, ___) {
                          return SizedBox(
                            height: 80,
                        width: 100,
                          );
                        },
                      )),
                  Space().width(
                    context,
                    0.03,
                  ),
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(houseName ?? "Orchad House",
                            style: appTheme.textTheme.displayLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: houseBlack100)),
                        Space().height(
                          context,
                          0.008,
                        ),
                        Text("GHS $amount / Year",
                            style: appTheme.textTheme.displaySmall!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: housePrimaryColor,
                                fontSize: 12)),
                        Space().height(
                          context,
                          0.01,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              bedSVG,
                            ),
                            Text(
                              "$bedRoomCount BedRoom",
                            ),
                            SvgPicture.asset(bathSVG),
                            Text(
                              "$bathhRoomCount BathRoom",
                            )
                          ],
                        )
                      ]),
                ]),
            Space().height(context, 0.025),
          ],
        ),
      ),
    );
  }
}
