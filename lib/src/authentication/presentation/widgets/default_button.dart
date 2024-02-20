import 'package:flutter/material.dart';
import 'package:house_rental/core/size/sizes.dart';

class DefaultButton extends StatelessWidget {
  final void Function()? onTap;
  final String? label;
  const DefaultButton({super.key, this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Sizes().height(context, 0.05),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(label!),
      ),
    );
  }
}
