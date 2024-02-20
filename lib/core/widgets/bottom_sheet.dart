import 'package:flutter/material.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';

Widget bottomSheetButton({
  required String label,
  required BuildContext context,
  required void Function()? onPressed,
}) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(
      horizontal: Sizes().width(context, 0.04),
      vertical: Sizes().width(context, 0.04),
    ),
    child: DefaultButton(
      onTap: onPressed,
      label: label,
    ),
  );
}
