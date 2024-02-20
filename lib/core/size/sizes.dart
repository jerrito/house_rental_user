import 'package:flutter/cupertino.dart';

class Sizes {
  //height definition
  double height(BuildContext context, double size) {
    return MediaQuery.of(context).size.height * size;
  }

  // width definition
  double width(BuildContext context, double size) {
    return MediaQuery.of(context).size.width * size;
  }
}
