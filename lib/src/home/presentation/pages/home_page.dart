import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';
import 'package:house_rental/core/widgets/show_toast.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/home/presentation/bloc/home_bloc.dart';
import 'package:house_rental/src/home/presentation/widgets/home_drawer.dart';
import 'package:house_rental/src/home/presentation/widgets/house_row_details.dart';
import 'package:house_rental/src/home/presentation/widgets/house_shimmer.dart';
import 'package:house_rental/src/home/presentation/widgets/row_buttons.dart';
import 'package:house_rental/src/home/presentation/widgets/search_textfield.dart';

class HomePage extends StatefulWidget {
  final String? uid;
  final bool? isLogin;
  final String? phoneNumber;
  const HomePage({
    super.key,
    this.uid,
    this.isLogin,
    this.phoneNumber,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authBloc = locator<AuthenticationBloc>();
  final homeBloc = locator<HomeBloc>();
  final homeBloc2 = locator<HomeBloc>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final searchController = TextEditingController();

  User? user;
  List<String> category = [
    "house",
    "hotel",
    "apartments",
    "single room",
    "chamber & hall"
  ];
  String value = "house";
  @override
  void initState() {
    super.initState();

    authBloc.add(const GetCacheDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: HomeDrawer(
          user: user ??
              User(
                  firstName: "",
                  lastName: "",
                  email: "",
                  phoneNumber: "",
                  id: "",
                  uid: "",
                  password: "",
                  profileUrl: ""),
        ),
        // appBar: AppBar(title: const Text("Home Page")),
        body: BlocListener(
            bloc: authBloc,
            listener: (context, state) {
              if (state is GetCacheDataLoaded) {
                user = state.user;

                setState(() {});
                Map<String, dynamic> params = {};
                homeBloc.add(GetAllHousesEvent(params: params));
                Map<String, dynamic> param = {"category": "house"};
                homeBloc2.add(
                  GetCategoryAllHousesEvent(params: param),
                );
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                    //  mainAxisSize : MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SingleChildScrollView(
                      //   child: ExpansionTile(
                      //     controlAffinity: ListTileControlAffinity.leading,
                      //     onExpansionChanged: (value){

                      //     },

                      //    expandedCrossAxisAlignment: CrossAxisAlignment.end,
                      //    expandedAlignment: Alignment.bottomCenter,
                      //     title:  const Text("Ja"),
                      //     children: [
                      //       const Text("La"),
                      //       const Text("UK"),
                      //       const Text("GE"),
                      //     ],
                      //   ),
                      // ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [SvgPicture.asset(notificationSVG)]),
                      Space().height(context, 0.02),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes().width(context, 0.04)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SearchTextField(
                              label: "Search address or near you",
                              onChanged: null,
                              controller: searchController,
                              onTap: null,
                            ),
                            GestureDetector(
                              onTap: () {
                                scaffoldKey.currentState?.openDrawer();
                                Future.delayed(const Duration(seconds: 1), () {
                                  // debugPrint(user?.id);

                                  //if(widget)
                                  if (user?.id == null || user?.uid == null) {
                                    Map<String, dynamic> params = {
                                      "phone_number": user?.phoneNumber,
                                      "uid": widget.uid,
                                    };
                                    authBloc.add(
                                      AddIdEvent(
                                        params: params,
                                      ),
                                    );
                                  }
                                });
                              },
                              child: SvgPicture.asset(
                                menuSVG,
                                height: 35,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Space().height(context, 0.02),

                      CarouselSlider.builder(
                          itemCount: category.length,
                          options: CarouselOptions(
                            viewportFraction: 0.3,
                            height: Sizes().height(context, 0.05),
                            reverse: true,
                          ),
                          itemBuilder: (context, index, values) {
                            return RowButtons(
                              onTap: () {
                                Map<String, dynamic> params = {
                                  "category": category[index]
                                };
                                value = category[index];
                                setState(() {});
                                homeBloc2.add(
                                  GetCategoryAllHousesEvent(
                                    params: params,
                                  ),
                                );
                              },
                              isSelected:
                                  category[index] == value ? true : false,
                              label: category[index],
                            );
                          }),
                      Space().height(context, 0.05),

                      BlocConsumer(
                        listener: (context, state) {
                          if (state is GetCategoryAllHousesError) {
                            showToastInfo(
                              context: context,
                              label: state.errorMessage,
                              isFailed: true,
                            );
                          }
                        },
                        bloc: homeBloc2,
                        builder: (context, state) {
                          if (state is GetCategoryAllHousesLoading) {
                            return const HouseContainerShimmer();
                          }
                          if (state is GetCategoryAllHousesLoaded) {
                            return CarouselSlider.builder(
                                itemCount: state.houseDetail.length,
                                options: CarouselOptions(
                                    height: Sizes().height(context, 0.342),
                                    viewportFraction: 0.6),
                                itemBuilder: (context, index, value) {
                                  final houseData =
                                      state.houseDetail[index].data();
                                  final id = state.houseDetail[index].id;
                                  return GestureDetector(
                                    onTap: () {
                                      context.pushNamed("houseDetail",
                                          queryParameters: {"id": id});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: houseContainerGradient,
                                            borderRadius: BorderRadius.circular(
                                                Sizes().height(context, 0.05)),
                                          ),
                                          height:
                                              Sizes().height(context, 0.342),
                                          width: Sizes().height(context, 0.444),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            22.0),
                                                    child: Image.network(
                                                      houseData.images?[0] ??
                                                          "",
                                                      errorBuilder:
                                                          (_, __, ___) {
                                                        return const SizedBox(
                                                          height: 272,
                                                        );
                                                      },
                                                      height: 272,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                      //opacity: const AlwaysStoppedAnimation(.3),
                                                    )

                                                    //child: ,
                                                    ),
                                              ),
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 25.0,
                                                      right: 12,
                                                    ),
                                                    child: Container(
                                                      width: 70,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            houseContainerRowColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          20.0,
                                                        ),
                                                      ),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              locationSVG,
                                                            ),
                                                            const Text(
                                                              "1.8 km",
                                                              style: TextStyle(
                                                                color:
                                                                    houseWhiteColor,
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                  )),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                      bottom: 16,
                                                    ),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            houseData
                                                                    .houseName ??
                                                                "",
                                                            style: appTheme
                                                                .textTheme
                                                                .displayLarge!
                                                                .copyWith(
                                                              color:
                                                                  houseWhiteColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            houseData
                                                                    .description ??
                                                                "",
                                                            style: appTheme
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                    color:
                                                                        searchTextColor3,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ]),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                          return const SizedBox(height: 100);
                        },
                      ),

                      Space().height(context, 0.032),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes().width(context, 0.04),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Best for you",
                                  style: appTheme.textTheme.displayLarge!
                                      .copyWith(fontWeight: FontWeight.w500)),
                              Text(
                                "See more",
                                style: appTheme.textTheme.displaySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: searchTextColor2,
                                        fontSize: 12),
                              )
                            ]),
                      ),

                      //Space().height(context, 0.02),

                      BlocConsumer(
                          listener: (context, state) {
                            if (state is GetAllHousesError) {
                              showToastInfo(
                                context: context,
                                label: state.errorMessage,
                                isFailed: true,
                              );
                            }
                          },
                          bloc: homeBloc,
                          builder: (context, state) {
                            if (state is GetAllHousesLoading) {
                              return const HouseListShimmer();
                            }
                            if (state is GetAllHousesLoaded) {
                              return ListView.builder(
                                  //reverse: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.houseDetail.length,
                                  itemBuilder: (context, index) {
                                    final houseData =
                                        state.houseDetail[index].data();
                                    final id = state.houseDetail[index].id;

                                    return HouseRowDetails(
                                      onTap: () {
                                        context.pushNamed("houseDetail",
                                            queryParameters: {"id": id});
                                      },
                                      bedRoomCount: houseData.bedRoomCount,
                                      bathhRoomCount: houseData.bathRoomCount,
                                      amount: houseData.amount,
                                      houseIMageURL: houseData.images?[0],
                                      houseName: houseData.houseName,
                                    );
                                  });
                            }
                            return SizedBox();
                          })

                      // const HouseRowDetails(),
                      // const HouseRowDetails(),
                      // const HouseRowDetails(),
                    ]),
              ),
            )));
  }
}

class Test {
  int i = 1;
  int sum() {
    return i++;
  }
}
