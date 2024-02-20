import 'dart:convert';

import 'package:crypto/crypto.dart';
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
import 'package:oktoast/oktoast.dart';
import 'package:string_validator/string_validator.dart';

showPinChangeProfileDialog(
  BuildContext context,
  String data,
  String? label,
  AuthenticationBloc bloc,
  String id,
  String update,
  String email,
  String oldValue,
  String newChangeValue,
  String newRepeatValue,
  GlobalKey<FormBuilderFieldState> formKey,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: SimpleDialog(
              contentPadding: EdgeInsets.symmetric(
                horizontal: Sizes().width(context, 0.04),
                vertical: Sizes().height(context, 0.01),
              ),
              title: Text("Edit $label"),
              children: [
                Space().height(
                  context,
                  0.01,
                ),
                FormBuilderField<String>(
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return fieldRequired;
                      }

                      if (!isLength(value!, 8)) {
                        return 'must be at least 8 characters';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: "old",
                    builder: (field) {
                      return DefaultTextfield(
                          label: "Enter old $label",
                          errorText: field.errorText,
                          onChanged: (p0) {
                            oldValue = p0!;
                            field.didChange(p0);
                          });
                    }),
                Space().height(context, 0.01),
                FormBuilderField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return fieldRequired;
                    }

                    if (!isLength(value!, 8)) {
                      return 'must be at least 8 characters';
                    }
                    if (newRepeatValue != value) {
                      return "Password doesn't match";
                    }
                    return null;
                  },
                  name: "change",
                  builder: (field) {
                    return DefaultTextfield(
                        label: "Enter new $label",
                        errorText: field.errorText,
                        onChanged: (p0) {
                          newChangeValue = p0!;
                          field.didChange(p0);
                        });
                  },
                ),
                Space().height(context, 0.01),
                FormBuilderField<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return fieldRequired;
                      }

                      if (!isLength(value!, 8)) {
                        return 'must be at least 8 characters';
                      }
                      if (newChangeValue != value) {
                        return "Password does't much";
                      }

                      return null;
                    },
                    name: "repeat",
                    builder: (field) {
                      return DefaultTextfield(
                        label: "Repeat new $label",
                        errorText: field.errorText,
                        onChanged: (p0) {
                          newRepeatValue = p0!;
                          field.didChange(p0);
                        },
                      );
                    }),
                Space().height(context, 0.02),
                BlocConsumer(
                  bloc: bloc,
                  listener: (context, state) async {
                    if (state is SigninLoaded) {
                      
                      var newBites = utf8.encode(newChangeValue);
                      var newPassword = sha512.convert(newBites);
                      Map<String, dynamic> params = {
                        "id": id,
                        update: newPassword.toString(),
                      };
                      bloc.add(
                        UpdateUserEvent(params: params),
                      );
                    }
                    if (state is UpdateUserLoaded) {
                      context.pop();
                    }
                    if (state is UpdateUserError) {
                      context.pop();
                      OKToast(
                        child: Text(
                          state.errorMessage,
                        ),
                      );
                    
                    }
                    if (state is SigninError) {
                    
                      const OKToast(
                        child: Text(
                          "Wrong Password",
                        ),
                      );
                     
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdateUserLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is SigninLoading) {
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
                              // if (formKey.currentState?.validate() == true) {
                              
                              var bites = utf8.encode(oldValue);
                              var password = sha512.convert(bites);
                              Map<String, dynamic> params = {
                                "email": email,
                                "password": password.toString(),
                                //"uid": widget.uid,
                              };

                              bloc.add(
                                SigninEvent(
                                  users: params,
                                ),
                              );
                              //}
                            },
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        );
      });
}
