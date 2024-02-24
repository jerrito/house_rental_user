// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/core/strings/app_strings.dart';
import 'package:house_rental/core/widgets/bottom_sheet.dart';
import 'package:house_rental/core/widgets/show_toast.dart';

import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/pages/otp_page.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

class SigninPage extends StatefulWidget {
  final String phoneNumber, uid, id;
  const SigninPage(
      {super.key,
      required this.phoneNumber,
      required this.uid,
      required this.id});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final authBloc = locator<AuthenticationBloc>();
  final formKey = GlobalKey<FormBuilderState>();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  bool isPhoneNumberLogin = true;
  @override
  void initState() {
    super.initState();
    authBloc.add(const GetCacheDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Signin Page")),
        bottomSheet: bottomSheetButton(
          context: context,
          label: "Signin",
          onPressed: () {
            if (type == UseNumber.emailPassword) {
              var bites = utf8.encode(passwordController.text);
              var password = sha512.convert(bites);
              final users = {
                "email": emailController.text,
                "password": password.toString(),
                //"uid": widget.uid,
              };

              authBloc.add(
                SigninEvent(
                  users: users,
                ),
              );
            } else {
              authBloc.add(
                PhoneNumberLoginEvent(
                  phoneNumber: "+233${phoneNumberController.text}",
                ),
              );
            }
          },
        ),
        body: FormBuilder(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                RadioListTile(
                    value: UseNumber.phoneNumber,
                    groupValue: type,
                    title: const Text("Use Phone Number"),
                    onChanged: (value) {
                      type = value!;
                      setState(() {});
                    }),
                RadioListTile(
                    value: UseNumber.emailPassword,
                    groupValue: type,
                    title: const Text("Use Email and Password"),
                    onChanged: (value) {
                      //value = UseNumber.phoneNumber;
                      type = value!;
                      setState(() {});
                    }),
                Visibility(
                  visible: type != UseNumber.phoneNumber,
                  replacement: BlocConsumer(
                    bloc: authBloc,
                    listener: (BuildContext context, Object? state) async {
                      if (state is CodeSent) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return OTPPage(
                              otpRequest: OTPRequest(
                                  isLogin: true,
                                  phoneNumber:
                                      "+233${phoneNumberController.text}",
                                  forceResendingToken: state.token,
                                  verifyId: state.verifyId,
                                  uid: widget.uid,
                                  id: widget.id),
                            );
                          }),
                        );
                      }
                      if (state is CodeCompleted) {
                        User? user = FirebaseAuth.instance.currentUser;

                        if (state.authCredential.smsCode != null) {
                          try {
                            UserCredential credential = await user!
                                .linkWithCredential(state.authCredential);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'provider-already-linked') {
                              final credential = await FirebaseAuth.instance
                                  .signInWithCredential(state.authCredential);
                            }
                          }
                        }
                      }

                      if (state is GenericError) {
                        if (!context.mounted) return;
                        showToastInfo(
                          context: context,
                          label: state.errorMessage,
                          isFailed: true,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is VerifyPhoneNumberLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return FormBuilderField<String>(
                          name: "phoneNumber",
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return fieldRequired;
                            }
                            if (!isNumeric(value!)) {
                              return "Only numbers required";
                            }
                            if (!isLength(value, 9)) {
                              return 'must be at least 8 characters';
                            }

                            return null;
                          },
                          onChanged: (value) {
                            if (value!.startsWith("0", 0)) {
                              value = value.substring(1);
                            }
                          },
                          builder: (context) {
                            return DefaultTextfield(
                              controller: phoneNumberController,
                              label: "Phone Number",
                              errorText: context.errorText,
                              onChanged: (p0) => context.didChange(p0),
                            );
                          });
                    },
                  ),

                  //email & password bloc
                  child: BlocConsumer(
                      bloc: authBloc,
                      listener: (context, state) async {
                        final preference =
                            await SharedPreferences.getInstance();
                        var uid = preference.getString("UIDKey");
                        var phoneNumber = preference.getString("phoneNumber");

                        if (state is SigninLoaded) {
                          if (!context.mounted) return;

                          context.goNamed("homePage", queryParameters: {
                            "uid": uid,
                            "isLogin": "true",
                            "phone_number": phoneNumber
                          });
                        }

                        if (state is SigninError) {
                          if (!context.mounted) return;
                          showToastInfo(
                            context: context,
                            label: state.errorMessage,
                            isFailed: true,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is SigninLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Column(
                          children: [
                            //email
                            FormBuilderField<String>(
                                name: "Email",
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return fieldRequired;
                                  }
                                  if (!isEmail(value!)) {
                                    return "Must be an email";
                                  }
                                  return null;
                                },
                                builder: (context) {
                                  return DefaultTextfield(
                                    controller: emailController,
                                    label: "Email",
                                    hintText: "Enter your email",
                                    errorText: context.errorText,
                                    onChanged: (p0) => context.didChange(p0),
                                  );
                                }),

                            //password
                            FormBuilderField<String>(
                                name: "password",
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return fieldRequired;
                                  }

                                  if (!isLength(value!, 8)) {
                                    return mustBeCharacters;
                                  }

                                  return null;
                                },
                                builder: (context) {
                                  return DefaultTextfield(
                                    controller: passwordController,
                                    label: "Password",
                                    hintText: "Enter your password",
                                    errorText: context.errorText,
                                    onChanged: (p0) => context.didChange(p0),
                                  );
                                }),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        )
        //   },
        // ),
        );
  }

  UseNumber type = UseNumber.phoneNumber;
}

enum UseNumber { phoneNumber, emailPassword }
