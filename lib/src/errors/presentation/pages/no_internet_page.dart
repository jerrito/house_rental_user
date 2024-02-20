import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/widgets/bottom_sheet.dart';
import 'package:go_router/go_router.dart';
class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //no wifi image
          Center(
            child: SvgPicture.asset(
              noWIFISVG,
              height: Sizes().height(context, 0.15),
            ),
          ),

          Space().height(context, 0.025),

          Text(
            "No Internet Connection",
            style: appTheme.textTheme.headlineLarge,
          ),
        ],
      ),
      bottomSheet: bottomSheetButton(
        context: context,
        onPressed: () => context.goNamed('connectionPage'),
        label: "Retry",
        
      ),
    );
  }
}
