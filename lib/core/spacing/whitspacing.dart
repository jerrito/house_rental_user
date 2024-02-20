import 'package:flutter/material.dart';
import 'package:house_rental/core/size/sizes.dart';

class Space {
  //custom spacing height
  height(BuildContext context, double size) {
    return SizedBox(
      height: Sizes().height(context, size),
    );
  }

  //custom spacing width

  width(BuildContext context, double size) {
    return SizedBox(
      width: Sizes().width(context, size),
    );
  }
}
