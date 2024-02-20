import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_textfield.dart';

showProfileNameDialog(
  BuildContext context,
  String data,
  String data2,
  String? label,
  String? label2,
  AuthenticationBloc bloc,
  String id,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.symmetric(
            horizontal: Sizes().width(context, 0.04),
            vertical: Sizes().height(context, 0.02),
          ),
          title: const Text("Edit Name"),
          children: [
            Space().height(context, 0.02),
            FormBuilderField(
              name:"firstName",
              builder:(context)=>
               DefaultTextfield(
                initialValue: data,
                label: "Enter $label",
                onChanged: (value) {
                  data = value!;
                },
              ),
            ),
             Space().height(context, 0.02),
            FormBuilderField(
              name:"secondName",
              builder:(context)=>
               DefaultTextfield(
                initialValue: data2,
                label: "Enter $label2",
                onChanged: (value) {
                  data2 = value!;
                },
              ),
            ),
            Space().height(context, 0.02),
            BlocConsumer(
              bloc: bloc,
                      listener: (context, state) {
                        if (state is UpdateUserLoaded) {
                          context.pop();
                        }
                        if (state is UpdateUserError) {}
                      },
                      builder: (context, state) {
                        if (state is UpdateUserLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: Sizes().width(context, 0.3),
                      child: DefaultButton(
                        label: "Cancel",
                        onTap: () {
                          context.pop();
                        },
                      ),
                    ),
                    SizedBox(
                          width: Sizes().width(context, 0.3),
                          child: DefaultButton(
                            label: "Update",
                            onTap: () {
                              Map<String, dynamic> params = {
                                "id": id,
                                "first_name": data,
                                "last_name": data2,
                              };
                              bloc.add(
                                UpdateUserEvent(params: params),
                              );
                            },
                          ),
                       
                    ),
                  ],
                );
              },
            )
          ],
        );
      });
}
