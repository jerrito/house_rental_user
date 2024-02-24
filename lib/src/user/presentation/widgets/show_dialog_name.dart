import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/strings/app_strings.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_textfield.dart';

showProfileNameDialog(
  BuildContext context,
  String data,
  String data2,
  String? label,
  String? label2,
  String id,
  AuthenticationBloc bloc
) {
  final formKey = GlobalKey<FormBuilderState>();
  final dataController = TextEditingController();
  final data2Controller = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        dataController.text = data;
        data2Controller.text = data2;
        return FormBuilder(
          key: formKey,
          child: SimpleDialog(
            contentPadding: EdgeInsets.symmetric(
              horizontal: Sizes().width(context, 0.04),
              vertical: Sizes().height(context, 0.02),
            ),
            title: const Text("Edit Name"),
            children: [
              Space().height(context, 0.02),
              FormBuilderField<String>(
                initialValue: dataController.text,
                name: "firstName",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return fieldRequired;
                  }
                  if (value!.length <= 1) {
                    return mustBeCharacters;
                  }
                  return null;
                },
                builder: (field) => DefaultTextfield(
                  errorText: field.errorText,
                  controller: dataController,
                  label: "Enter $label",
                  onChanged: (value) {
                    data = value!;
                    field.didChange(value);
                  },
                ),
              ),
              Space().height(context, 0.02),
              FormBuilderField<String>(
                initialValue: data2Controller.text,
                name: "secondName",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return fieldRequired;
                  }
                  if (value!.length <= 1) {
                    return mustBeCharacters;
                  }
                  return null;
                },
                builder: (field) => DefaultTextfield(
                  controller: data2Controller,
                  errorText: field.errorText,
                  label: "Enter $label2",
                  onChanged: (value) {
                    data2 = value!;
                    field.didChange(value);
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
                            if (formKey.currentState?.saveAndValidate() ==
                                true) {
                              Map<String, dynamic> params = {
                                "id": id,
                                "first_name": data,
                                "last_name": data2,
                              };
                              bloc.add(
                                UpdateUserEvent(params: params),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        );
      });
}
