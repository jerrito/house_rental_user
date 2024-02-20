// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';

class DefaultTextfield extends StatelessWidget {
  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  final String? hintText, initialValue, errorText, label;
  final double? height;
  final bool? enabled;
  final TextInputType? textInputType;
  const DefaultTextfield(
      {super.key,
      this.onChanged,
       this.controller,
      this.hintText,
      this.textInputType,
      this.errorText,
      this.height,
       this.label,
      this.initialValue,
      this.enabled,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //height: Sizes().height(context, 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label!),
          Space().height(context, 0.004),
          // SizedBox(
          //   height: Sizes().height(context, 0.06),
          //     child:
          SizedBox(
            height: height,
            child: TextFormField(
              enabled: enabled,
             initialValue: initialValue,
              keyboardType: textInputType,
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                isDense: true,
                errorText: errorText,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                //label: Text(label!),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Sizes().height(context, 0.04)),
                  borderSide: const BorderSide(color: Colors.black26),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Sizes().height(context, 0.04)),
                  borderSide: const BorderSide(color: Colors.black26),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Sizes().height(context, 0.04)),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ),
          //),
          Space().height(context, 0.03)
        ],
      ),
    );
  }
}

class DefaultTextArea extends StatelessWidget {
  final void Function(String?)? onChanged;
  final void Function(PointerDownEvent)? onTapOutSide;
  final TextEditingController? controller;
  final String? hintText, initialValue, errorText, label;
  final double? height;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  const DefaultTextArea({
    Key? key,
    this.onChanged,
     this.controller,
    this.hintText,
    this.errorText,
    this.label,
    this.height,
    this.textInputType,
    this.focusNode,
    this.onTapOutSide,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? ""),
          Space().height(context, 0.004),
        SizedBox(
          height:100,width:double.infinity,
          child: TextFormField(

             focusNode:focusNode,
             initialValue:initialValue,
            expands: true,
            maxLines: null,
            minLines: null,
             keyboardType: textInputType,
              controller: controller,
              onChanged: onChanged,
                onTapOutside:onTapOutSide,
              decoration: InputDecoration(
                
                   isDense: true,
                    errorText: errorText,
                   contentPadding:const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                   hintText: hintText,
                    hintStyle: const TextStyle(color: Colors.grey),
                    //label: Text(label!),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(Sizes().height(context, 0.01)),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(Sizes().height(context, 0.01)),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(Sizes().height(context, 0.01)),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
          
          ),
        ),
        Space().height(context, 0.02)
      ],
    );
  }
}
