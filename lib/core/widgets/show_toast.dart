import 'package:flutter/material.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:oktoast/oktoast.dart';

ToastFuture showToastInfo(
    { required BuildContext context,
    required String label,
      required bool isFailed,
        }) {
  return // position and second have default value, is optional
      showToastWidget(
    duration: const Duration(seconds: 3),
    position: ToastPosition.top,
    Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.02)),
      child: Container(
        width: double.infinity,
        height: Sizes().height(context, 0.07),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes().height(context, 0.01)),
            color: isFailed
                ? const Color.fromRGBO(191, 9, 21, 0.894)
                : const Color.fromARGB(228, 6, 136, 6)),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
