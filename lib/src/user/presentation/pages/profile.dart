import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/home/presentation/bloc/home_bloc.dart';
import 'package:house_rental/src/home/presentation/widgets/build_profile_change.dart';
import 'package:house_rental/src/user/presentation/widgets/profile_list.dart';
import 'package:house_rental/src/user/presentation/widgets/show_dialog.dart';
import 'package:house_rental/src/user/presentation/widgets/show_dialog_name.dart';
import 'package:house_rental/src/user/presentation/widgets/show_dialog_pin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final homeBloc = locator<HomeBloc>();
  final authBloc = locator<AuthenticationBloc>();
  final formKey = GlobalKey<FormBuilderFieldState>();
  String? newRepeatValue;
  String? newChangeValue;
  String? oldValue;
  User? owner;
  @override
  Widget build(BuildContext context) {
    authBloc.add(const GetCacheDataEvent());
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SingleChildScrollView(
        child: BlocConsumer(
          bloc: authBloc,
          listener: (context, state) async {
            if (state is GetCacheDataLoaded) {
              owner = state.user;
              setState(() {});
            }
          },
          builder: (context, state) {
            if (state is GetCacheDataLoaded) {
              return Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: Sizes().height(context, 0.2),
                        width: Sizes().width(context, 0.4),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  Image.network(owner?.profileUrl ?? "").image),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await buildProfileChangeBottomSheet(
                            context,
                            homeBloc,
                            authBloc,
                            owner?.id,
                            owner?.phoneNumber,
                          );

                          authBloc.add(const GetCacheDataEvent());
                        },
                        child: const Icon(
                          size: 40,
                          Icons.camera_alt_outlined,
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Space().height(context, 0.1),
                  ProfileList(
                      onPressed: () async {
                        await showProfileNameDialog(
                          context,
                          owner?.firstName ?? "",
                          owner?.lastName ?? "",
                          "First Name",
                          "Last Name",                  
                          owner?.id ?? "",
                          authBloc,
                        );

                        authBloc.add(const GetCacheDataEvent());
                      },
                      data: "${owner?.firstName} ${owner?.lastName}"),
                  ProfileList(
                      onPressed: () async {
                        await showProfileDialog(
                          context,
                          owner?.email ?? "",
                          "Email",
                          owner?.id ?? "",
                          "email",
                          authBloc,
                        );
                        authBloc.add(const GetCacheDataEvent());
                      },
                      data: "${owner?.email}"),
                  ProfileList(
                      onPressed: () async {
                        await context.pushNamed("phoneNumber",
                            queryParameters: {
                              "isLogin": "false",
                              "oldNumberString": owner?.phoneNumber
                            });
                        authBloc.add(const GetCacheDataEvent());
                      },
                      data: "${owner?.phoneNumber}"),
                  ProfileList(
                      onPressed: () async {
                        await showPinChangeProfileDialog(
                            context,
                            owner?.password ?? "",
                            "Password",
                            authBloc,
                            owner?.id ?? "",
                            "password",
                            owner?.email ?? "",
                            oldValue ?? "",
                            newChangeValue ?? "",
                            newRepeatValue ?? "",
                            formKey);
                        authBloc.add(const GetCacheDataEvent());
                      },
                      data: "Change Pin"),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
