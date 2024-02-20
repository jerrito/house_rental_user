// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';

class DrawerListTile extends StatelessWidget {
  final int itemNumber;
  final void Function() onTap;
  const DrawerListTile({
    super.key,
    required this.itemNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(itemNumber==1?
      userSVG:itemNumber == 2
              ? settingsSVG
              : itemNumber == 3
                  ?pocketSVG:
                  itemNumber==4?
                  mapPinSVG:
                  itemNumber==5?
                  bookMarkSVG:
                  itemNumber==6?
                  notificationSVG:
                  itemNumber==7?
                  messageCircleSVG
                  : logOutSVG,color: houseWhiteColor,),
      title: Text(itemNumber == 1
          ? "Profile Settings"
          : itemNumber == 2
              ? "Settings Page"
              : itemNumber == 3
                  ? "About Us":
                  itemNumber==4?
                  "Nearby":
                  itemNumber==5?
                  "Bookmark":
                  itemNumber==6?
                  "Notification":
                  itemNumber==7?
                  "Message"
                  : "Log out",style: appTheme.textTheme.displayLarge!.copyWith(
                    color: houseWhiteColor,fontWeight: FontWeight.w400
                  ),),
    );
  }
}
