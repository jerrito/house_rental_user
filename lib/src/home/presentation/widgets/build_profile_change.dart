import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/core/widgets/show_toast.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental/src/home/presentation/bloc/home_bloc.dart';

buildProfileChangeBottomSheet(
  BuildContext context,
  HomeBloc homeBloc,
  AuthenticationBloc authBloc,
  String? id,
  String? phoneNumber,
) {
  return showModalBottomSheet(
    isDismissible:false,
      context: context,
      builder: ((context) {
        return Container(
            height: Sizes().height(context, 0.3),
            padding: EdgeInsets.all(Sizes().width(context, 0.04)),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.s,
              children: [
                Space().height(context, 0.02),
                const Text("Update profile"),
                Space().height(context, 0.04),
                BlocConsumer(
                    bloc: authBloc,
                    listener: (context, state) async {
                      if (state is UpLoadImageError) {
                         showToastInfo(
                              context: context,
                              label: state.errorMessage,
                              isFailed: true,
                            );
                      }

                      if (state is UpLoadImageLoaded) {
                        Map<String, dynamic> params = {
                          "id": id ?? "",
                          "profile_url": state.imageURL,
                        };
                        authBloc.add(UpdateUserEvent(params: params));
                      }

                      if (state is UpdateUserLoaded) {
                         showToastInfo(
                              context: context,
                              label: "Profile updated",
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
                      if (state is GetProfileError) {
                         showToastInfo(
                              context: context,
                              label: state.errorMessage,
                              isFailed: true,
                            );
                      }
                      if (state is GetProfileLoaded) {
                        Map<String, dynamic> params = {
                          "phone_number": phoneNumber ?? "",
                          "path": state.file.path,
                        };

                        authBloc.add(UpLoadImageEvent(params: params));
                      }
                    },
                    builder: (context, state) {
                      if (state is UpLoadImageLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is UpdateUserLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        children: [
                          DefaultButton(
                              label: "Camera",
                              onTap: () {
                                authBloc.add(
                                    GetProfileCameraEvent(params: NoParams()));
                              }),
                          Space().height(context, 0.02),
                          DefaultButton(
                              label: "Gallery",
                              onTap: () {
                                authBloc.add(
                                  GetProfileGalleryEvent(params: NoParams()),
                                );
                              })
                        ],
                      );
                    }),
              ],
            ));
      }));
}
