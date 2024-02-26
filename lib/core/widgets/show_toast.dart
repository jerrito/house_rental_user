import 'package:flutter/material.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:oktoast/oktoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
ToastFuture showToastInfos(
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






  

  showToastInfo({required String label,required  BuildContext context,required bool isFailed}) 
  {
    FToast fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
    Widget toast = Container(
      padding:  EdgeInsets.symmetric(
        horizontal: Sizes().width(context, 0.04),
        vertical: 16,
      ),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isFailed
                ? const Color.fromRGBO(191, 9, 21, 0.894)
                : const Color.fromARGB(228, 6, 136, 6),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );

    fToast.showToast(
      isDismissable: true,
        child: toast,
        toastDuration: const Duration(milliseconds: 3500),
        positionedToastBuilder: (context, child) {
          return Positioned(
            top: 100.0,
            left: 0,
            child: child,
          );
        });
  }
