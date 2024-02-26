import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/strings/app_strings.dart';
import 'package:house_rental/core/widgets/show_toast.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:string_validator/string_validator.dart';

showProfileDialog(
  BuildContext context,
  String data,
  String? label,
  String id,
  String update,
  AuthenticationBloc bloc
) {
    final formKey = GlobalKey<FormBuilderState>();

  return showDialog(
      context: context,
      builder: (context) {
        return FormBuilder(
          key: formKey,
          child: SimpleDialog(
            contentPadding: EdgeInsets.symmetric(
              horizontal: Sizes().width(context, 0.04),
              vertical: Sizes().height(context, 0.02),
            ),
            title: Text("Edit $label"),
            children: [
              Space().height(context, 0.02),
              
              FormBuilderField<String>(
                initialValue: data,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: "",
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return fieldRequired;
                  }
                  if (label == "Email") {
                    if (!isEmail(value!)) {
                      return "Email is required";
                    }
                  }
                  return null;
                },
                builder: (field) => DefaultTextfield(
                  initialValue: data,
                  label: "Enter $label",
                  errorText: field.errorText,
                  onChanged: (value) {
                    data = value!;
                    field.didChange(value);
                  },
                ),
              ),
              Space().height(context, 0.02),
              BlocConsumer(
                bloc: bloc,
                listener: (context, state) {
                  if (state is UpdateUserLoaded) {
                    showToastInfo(
                              context: context,
                              label: "Profile update success",
                              isFailed: false,
                            );
                    context.pop();
                  }
                  if (state is UpdateUserError) {
                    showToastInfo(
                              context: context,
                              label: state.errorMessage,
                              isFailed: true,
                            );
                  }
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
                            if (formKey.currentState?.saveAndValidate() == true) {
                              Map<String, dynamic> params = {
                                "id": id,
                                update: data
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
