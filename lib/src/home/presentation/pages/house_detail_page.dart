import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental/src/home/presentation/bloc/home_bloc.dart';
import 'package:house_rental/src/home/presentation/widgets/gallery_row.dart';
import 'package:house_rental/src/home/presentation/widgets/house_detail_container.dart';
import 'package:house_rental/src/home/presentation/widgets/house_detail_shimmer.dart';
import 'package:house_rental/src/home/presentation/widgets/house_shimmer.dart';
import 'package:house_rental/src/home/presentation/widgets/owner_row_detail.dart';
import 'package:go_router/go_router.dart';

class HouseDetailPage extends StatefulWidget {
  final String? id;

  const HouseDetailPage({
    super.key,
    this.id,
  });

  @override
  State<HouseDetailPage> createState() => _HouseDetailPageState();
}

class _HouseDetailPageState extends State<HouseDetailPage> {
  final homeBloc = locator<HomeBloc>();
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> params = {"id": widget.id};
    homeBloc.add(GetHouseEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
          listener: (context, state) {},
          bloc: homeBloc,
          builder: (context, state) {
            if (state is GetHouseLoading) {
              return const HouseDetailShimmer();
            }
            if (state is GetHouseLoaded) {
              final data = state.houseDetail;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Space().height(context, 0.05),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes().width(context, 0.04),
                        ),
                        child: HouseDetailContainer(
                          description: data?.description,
                          bathhRoomCount: data?.bathRoomCount,
                          bedRoomCount: data?.bedRoomCount,
                          houseName: data?.houseName,
                          houseIMageURL: data?.images?[0],
                          arrowBackOnTap: () {
                            context.pop();
                          },
                          favouriteOnTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) {
                              return const  HouseShimmer();
                          }
                            
                          ));
                          },
                        ),
                      ),
                      Space().height(context, 0.020),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes().width(context, 0.04),
                        ),
                        child: Text(
                          "Description",
                          style: appTheme.textTheme.displayLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: houseBlack100),
                        ),
                      ),
                      Space().height(context, 0.015),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes().width(context, 0.04),
                        ),
                        child: Text(
                          data?.description ?? "",
                          style: appTheme.textTheme.displayLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: searchTextColor1,
                              fontSize: 12),
                        ),
                      ),
                      Space().height(context, 0.024),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes().width(context, 0.04),
                        ),
                        child: OwnerRowDetails(
                          ownerName:
                              "${data?.owner?.firstName} ${data?.owner?.lastName}",
                          ownerPhotoURL: data?.owner?.profileURL,
                          role: data?.owner?.role,
                          callOnTap: () {
                            homeBloc.launchUrl(
                              "tel",
                              data?.owner?.phoneNumber ?? "",
                            );
                          },
                          messageOnTap: () {
                            homeBloc.launchUrl(
                              "sms",
                              data?.owner?.phoneNumber ?? "",
                            );
                          },
                        ),
                      ),
                      Space().height(context, 0.022),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes().width(context, 0.04),
                        ),
                        child: Text(
                          "Gallery",
                          style: appTheme.textTheme.displayLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: houseBlack100),
                        ),
                      ),
                      Space().height(context, 0.018),
                      GalleryRow(
                        itemCount: (data?.images?.length ?? 1),
                        image: data!.images!,
                      ),
                      Space().height(context, 0.022),
                      Container(
                          width: double.infinity,
                          height: Sizes().height(context, 0.14),
                          decoration: BoxDecoration(
                              color: searchTextColor1,
                              borderRadius: BorderRadius.circular(10)),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  data.houseLocation!.lat!.toDouble(),
                                  data.houseLocation!.lng!.toDouble()),
                              zoom: 12.4746,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          )),
                      Space().height(context, 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes().width(context, 0.04),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("GHS ${data.amount} / Year",
                                style:
                                    appTheme.textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: houseBlack100,
                                )),
                            SizedBox(
                              width: Sizes().height(context, 0.16),
                              height: Sizes().height(context, 0.05),
                              child: DefaultButton(
                                label: "Rent Now",
                                onTap: () {},
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          }),
    );
  }

  Set<Marker> mar = {const Marker(markerId: MarkerId("markerId"))};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
}
