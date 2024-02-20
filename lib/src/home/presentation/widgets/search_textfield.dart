import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';

class SearchTextField extends StatefulWidget {
  final String label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  /// Creates a search textfield widget with a prefix icon
  const SearchTextField({
    super.key,
    required this.label,
    required this.onChanged,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    required this.onTap,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes().height(context, 0.050),
      width: Sizes().width(context, 0.758),
      child: TextField(
        style: appTheme.textTheme.displaySmall!.copyWith(
          fontSize: 12,fontWeight: FontWeight.w400
        ),
        cursorColor: houseBlack100,
        controller: widget.controller,
        onChanged: widget.onChanged,
        enableSuggestions: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: Sizes().width(context, 0.055),
            right: Sizes().width(context, 0.030),
          ),
          prefixIconConstraints:
              BoxConstraints(maxHeight: Sizes().height(context, 0.024)),
          hintText: widget.label,
          hintStyle: appTheme.textTheme.displaySmall!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: searchTextColor1),
          filled: true,
          fillColor: searchBackgroundColor,
          prefixIcon: Padding(
            padding: EdgeInsets.only(
              left: Sizes().width(context, 0.048),
              right: Sizes().width(context, 0.024),
            ),
            child: GestureDetector(
              onTap: widget.onTap,
              child: SvgPicture.asset(
                searchSVG,
              ),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: searchBackgroundColor),
            borderRadius: BorderRadius.circular(
              Sizes().height(context, 0.013),
            ),
          ),
          enabledBorder: OutlineInputBorder(
             borderSide: const BorderSide(color: searchBackgroundColor),
            borderRadius: BorderRadius.circular(
              Sizes().height(context, 0.013),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Sizes().height(context, 0.013),
            ),
          ),
        ),
      ),
    );
  }
}
