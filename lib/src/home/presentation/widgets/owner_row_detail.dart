import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental/assets/images/image_constants.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';

class OwnerRowDetails extends StatelessWidget {
  final String? ownerName, role, ownerPhotoURL;
  final void Function()? callOnTap, messageOnTap;
  const OwnerRowDetails({
    super.key,
    this.ownerName,
    this.role,
    this.ownerPhotoURL,
    this.callOnTap,
    this.messageOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: searchTextColor1,
              backgroundImage: Image.network(ownerPhotoURL ?? "").image,
            ),
            Space().width(context, 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ownerName ?? "",
                  style: appTheme.textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w500, color: houseBlack100),
                ),
                Text(
                 role ?? "Owner",
                  style: appTheme.textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: searchTextColor1,
                      fontSize: 12),
                )
              ],
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: callOnTap,
              child: Container(
                decoration: BoxDecoration(
                    color: housePrimaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: SvgPicture.asset(callSVG),
              ),
            ),
            Space().width(context, 0.04),
            GestureDetector(
               onTap: messageOnTap,
              child: Container(
                decoration: BoxDecoration(
                    color: housePrimaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: SvgPicture.asset(messageSVG),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
