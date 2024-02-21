import 'package:flutter/material.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';

class RowButtons extends StatelessWidget {
  final bool isSelected;
  final String label;
  final void Function()? onTap;
  const RowButtons({super.key, required this.isSelected,
  this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
            gradient: isSelected ? primaryGradient : searchTextGradient,
            // color: isSelected ? housePrimaryColor : searchBackgroundColor,
            borderRadius: BorderRadius.circular(10.0)),
        height: 50,
        width: 100,
        child: Center(
          child: Text(
            label,
            style: appTheme.textTheme.displaySmall!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? houseWhiteColor : houseBlack100),
          ),
        ),
      ),
    );
  }
}
