// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/widgets/bottom_sheet.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:house_rental/src/home/presentation/pages/home_page.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:house_rental/core/strings/app_strings.dart';

class SignupPage extends StatefulWidget {
  final String phoneNumber, uid;
  const SignupPage({
    Key? key,
    required this.phoneNumber,
    required this.uid,
  }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final authBloc = locator<AuthenticationBloc>();
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormBuilderState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Signup"),
        ),
        bottomSheet: bottomSheetButton(
          context: context,
          label: "Signup",
          onPressed: () {
            if (formKey.currentState!.saveAndValidate() == true) {
              var bites = utf8.encode(passwordController.text);
              var password = sha512.convert(bites);
              final users = {
                "first_name": firstNameController.text,
                "last_name": lastNameController.text,
                "email": emailController.text,
                "phone_number": widget.phoneNumber,
                //"id": "",
                "password": password.toString(),
                "uid": widget.uid,
              };

              authBloc.add(
                SignupEvent(users: users),
              );
            }
          },
        ),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            bloc: authBloc,
            listener: (context, state) {
              if (state is GenericError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }

              if (state is SignupLoaded) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HomePage(
                      uid: widget.uid,
                      isLogin: false,
                      phoneNumber: widget.phoneNumber,
                    );
                  }),
                );
                //  GoRouter.of(context).pushReplacementNamed("homePage");
              }
            },
            builder: (context, state) {
              if (state is SignupLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return FormBuilder(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes().height(context, 0.02)),
                    child: Column(
                      children: [
                        //firstName
                        FormBuilderField<String>(
                            name: "First Name",
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Field is required";
                              }
                              if (value!.length <= 1) {
                                return 'must be atleast two characters or more ';
                              }
                              return null;
                            },
                            builder: (context) {
                              return DefaultTextfield(
                                controller: firstNameController,
                                label: "First Name",
                                hintText: "Enter your first name",
                                errorText: context.errorText,
                                onChanged: (p0) => context.didChange(p0),
                              );
                            }),

                        //last Name
                        FormBuilderField<String>(
                            name: "Last Name",
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return fieldRequired;
                              }
                              if (value!.length <= 1) {
                                return mustBeCharacters;
                              }
                              return null;
                            },
                            builder: (context) {
                              return DefaultTextfield(
                                controller: lastNameController,
                                label: "Last Name",
                                hintText: "Enter your last name",
                                errorText: context.errorText,
                                onChanged: (p0) => context.didChange(p0),
                              );
                            }),

                        //email
                        FormBuilderField<String>(
                            name: "Email",
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return fieldRequired;
                              }
                              if (!isEmail(value!)) {
                                return "Must be an email";
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            builder: (context) {
                              return DefaultTextfield(
                                controller: emailController,
                                label: "Email",
                                hintText: "Enter your email",
                                errorText: context.errorText,
                                onChanged: (p0) => context.didChange(p0),
                              );
                            }),

                        //email
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

                        Space().height(context, 0.02),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
