import 'package:flutter/material.dart';
import 'package:house_rental/core/size/sizes.dart';

class ProfileList extends StatelessWidget {
  final void Function()? onPressed;
  final String data;
  const ProfileList({
    super.key,
    required this.onPressed,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
     padding: EdgeInsets.symmetric(
        horizontal: Sizes().width(context,0.04),
        vertical: Sizes().height(context,0.01),

      ),
      child: Container( 
        padding: EdgeInsets.symmetric(
        horizontal: Sizes().width(context,0.02),
        vertical: Sizes().height(context,0.005),

      ),      
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color:Colors.black12,
            borderRadius: BorderRadius.circular(10)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data),
                IconButton(icon:const Icon(Icons.edit, color: Colors.blue,), 
                onPressed: onPressed)
              ])),
    );
  }
}
