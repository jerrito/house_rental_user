import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/widgets/show_toast.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

buildLogoutBottomSheet(
    BuildContext context, AuthenticationBloc authBloc, User? user) {
  return showModalBottomSheet(
      context: context,
      builder: ((context) {
        return Container(
            height: 200,
            padding: EdgeInsets.all(Sizes().width(context, 0.04)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Space().height(context, 0.02),
                const Text("Log out of your account"),
                Space().height(context, 0.04),
                BlocConsumer(
                    bloc: authBloc,
                    listener: (context, state) async {
                      const uidKey = "UIDKey";
                      const phoneNumber = "phoneNumber";
                      final preferences = await SharedPreferences.getInstance();
                      if (state is UpdateUserError) {
                        if (!context.mounted) return;
                        showToastInfo(
                              context: context,
                              label: state.errorMessage,
                              isFailed: true,
                            );
                      }

                      if (state is UpdateUserLoaded) {
                        // context.pop();
                        // context.goNamed("signin");
                        if (!context.mounted) return;
                         showToastInfo(
                              context: context,
                              label: "Log out success",
                              isFailed: true,
                            );

                        preferences.setString(uidKey, user!.uid!);
                        preferences.setString(phoneNumber, phoneNumber);

                        
                        GoRouter.of(context).goNamed("signin");
                      }
                    },
                    builder: (context, state) {
                      if (state is UpdateUserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return DefaultButton(
                          label: "Log out",
                          onTap: () {
                            Map<String, dynamic> params = {
                              "id": user!.id!,
                              "uid": null,
                              "first_name": user.firstName,
                              "last_name": user.lastName,
                              "email": user.email,
                              "phone_number": user.phoneNumber,
                            };
                            authBloc.add(UpdateUserEvent(params: params));
                          });
                    }),
                Space().height(context, 0.02),
                DefaultButton(
                    label: "Cancel",
                    onTap: () {
                      context.pop();
                    })
              ],
            ));
      }));
}
