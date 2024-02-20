// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/assets/images/image_constants.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/size/sizes.dart';

import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/home/presentation/bloc/home_bloc.dart';
import 'package:house_rental/src/home/presentation/widgets/build_logout_bottomsheet.dart';
import 'package:house_rental/src/home/presentation/widgets/build_profile_change.dart';
import 'package:house_rental/src/home/presentation/widgets/drawer_list_tile.dart';

class HomeDrawer extends StatefulWidget {
  final User user;

  const HomeDrawer({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final authBloc = locator<AuthenticationBloc>();
  final homeBloc = locator<HomeBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc:authBloc,
      listener: (context, state) {
        if(state is GetCacheDataLoaded){
          
        }
      },
      child: Container(
        width: Sizes().width(context, 0.75),
        decoration: BoxDecoration(
            gradient: primaryGradient,
            color: blueOceanColor1,
            borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          Space().height(context, 0.05),
          SizedBox(
            height: Sizes().height(context, 0.08),
            width: Sizes().width(context, 0.18),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: searchTextColor1,
                    backgroundImage: widget.user.profileUrl != null
                        ? Image.network(widget.user.profileUrl!).image
                        : Image.asset(user1Image, width: 100, height: 100)
                            .image,
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () async {
                        final data = await buildProfileChangeBottomSheet(
                            context, homeBloc,
                              authBloc,
                              widget.user.id,
                              widget.user.phoneNumber,);
                        if (data == "updated") {
                          authBloc.add(const GetCacheDataEvent());
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: primaryGradient,
                              shape: BoxShape.circle),
                          child: SvgPicture.asset(cameraSVG)),
                    ))
              ],
            ),
          ),
          Space().height(context, 0.02),
          Text(
            "${widget.user.firstName} ${widget.user.lastName}",
            style: appTheme.textTheme.displayLarge!
                .copyWith(color: houseWhiteColor, fontWeight: FontWeight.w400),
          ),
          Space().height(context, 0.02),
          Text(
            widget.user.phoneNumber ?? "",
            style: appTheme.textTheme.displayLarge!
                .copyWith(color: houseWhiteColor, fontWeight: FontWeight.w400),
          ),
          Space().height(context, 0.04),
          DrawerListTile(
            itemNumber: 1,
            onTap: () {
              context.pushNamed("profile");
            },
          ),
          DrawerListTile(
            itemNumber: 2,
            onTap: () {},
          ),
          DrawerListTile(
            itemNumber: 3,
            onTap: () {},
          ),
          DrawerListTile(
            itemNumber: 4,
            onTap: () {},
          ),
          DrawerListTile(
            itemNumber: 5,
            onTap: () {},
          ),
          DrawerListTile(
            itemNumber: 6,
            onTap: () {},
          ),
          DrawerListTile(
            itemNumber: 7,
            onTap: () {},
          ),
          DrawerListTile(
            itemNumber: 8,
            onTap: () {
              buildLogoutBottomSheet(context, authBloc, widget.user);
            },
          ),
        ]),
      ),
    );
  }
}
