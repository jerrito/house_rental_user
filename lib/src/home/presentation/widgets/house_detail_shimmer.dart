import "package:flutter/material.dart";
import "package:house_rental/core/size/sizes.dart";
import "package:house_rental/core/spacing/whitspacing.dart";
import "package:shimmer/shimmer.dart";

class HouseDetailShimmer extends StatelessWidget {
  const HouseDetailShimmer({super.key});

  final gradient = const LinearGradient(colors: [
    Color.fromARGB(66, 224, 220, 220),
    Color.fromARGB(221, 143, 141, 141),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:EdgeInsets.symmetric(
            horizontal:Sizes().width(context, 0.04),),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
               Space().height(context,0.01),
              //house container
              Shimmer(
                gradient: gradient,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                       color: const Color.fromARGB(66, 224, 220, 220),
                      borderRadius: BorderRadius.circular(
                        Sizes().height(context, 0.05),
                      ),
                    ),
                    height: Sizes().height(context, 0.34),
                    width: double.infinity,
                  ),
                ),
              ),
              
              Space().height(context,0.02),
            
              //description
              Shimmer(
                gradient: gradient,
                child: Container(
                  decoration: BoxDecoration(
                     color: const Color.fromARGB(66, 224, 220, 220),
                    borderRadius: BorderRadius.circular(
                      Sizes().height(context, 0.005),
                    ),
                  ),
                  height: Sizes().height(context, 0.02),
                  width: Sizes().width(context, 0.4),
                ),
              ),
            Space().height(context,0.02),
              //description detail
              Shimmer(
                gradient: gradient,
                child: Container(
                  decoration: BoxDecoration(
                     color: const Color.fromARGB(66, 224, 220, 220),
                    borderRadius: BorderRadius.circular(
                      Sizes().height(context, 0.003),
                    ),
                  ),
                  height: Sizes().height(context, 0.02),
                  width: Sizes().width(context, 0.8),
                ),
              ),
               Space().height(context,0.02),
            
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //profile
                  Shimmer(
                    gradient: gradient,
                    child: Container(
                      decoration: const BoxDecoration(
                         color:Color.fromARGB(66, 224, 220, 220),
                        shape: BoxShape.circle),
                      height: Sizes().height(context, 0.05),
                      width: Sizes().width(context, 0.10),
                    ),
                  ),
                 
                  Space().width(context,0.06),
                  //owner & role
                  Column(
                    children: [
                      Shimmer(
                        gradient: gradient,
                        child: Container(
                          decoration: BoxDecoration(
                             color: const Color.fromARGB(66, 224, 220, 220),
                            borderRadius: BorderRadius.circular(
                              Sizes().height(context, 0.005),
                            ),
                          ),
                          height: Sizes().height(context, 0.01),
                          width: Sizes().width(context, 0.14),
                        ),
                      ),

                       Space().height(context,0.01),

                        Shimmer(
                        gradient: gradient,
                        child: Container(
                          decoration: BoxDecoration(
                             color: const Color.fromARGB(66, 224, 220, 220),
                            borderRadius: BorderRadius.circular(
                              Sizes().height(context, 0.005),
                            ),
                          ),
                          height: Sizes().height(context, 0.01),
                          width: Sizes().width(context, 0.14),
                        ),
                      ),
                    ],
                  ),
            Space().width(context,0.4),
                  //phone icon & message icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Shimmer(
                        gradient: gradient,
                        child: Container(
                          decoration: BoxDecoration(
                             color: const Color.fromARGB(66, 224, 220, 220),
                            borderRadius: BorderRadius.circular(
                              Sizes().height(context, 0.005),
                            ),
                          ),
                          height: Sizes().height(context, 0.035),
                          width: Sizes().width(context, 0.08),
                        ),
                      ),
                       Space().width(context,0.05),

                        //mesage icon
                        Shimmer(
                    gradient: gradient,
                    child: Container(
                      decoration: BoxDecoration(
                         color: const Color.fromARGB(66, 224, 220, 220),
                        borderRadius: BorderRadius.circular(
                          Sizes().height(context, 0.005),
                        ),
                      ),
                      height: Sizes().height(context, 0.035),
                      width: Sizes().width(context, 0.08),
                    ),
                  ),
                    ],
                  ),
            
                 
                 
                ],
              ),
             
              Space().height(context,0.02),
              //gallery text
              Shimmer(
                gradient: gradient,
                child: Container(
                  decoration: BoxDecoration(
                  color: const Color.fromARGB(66, 224, 220, 220),
                    borderRadius: BorderRadius.circular(
                      Sizes().height(context, 0.005),
                    ),
                  ),
                  height: Sizes().height(context, 0.01),
                  width: Sizes().width(context, 0.14),
                ),
              ),
            
             Space().height(context,0.01),
              //house gallery container
              Row(
                children: [
                  Shimmer(
                        gradient: gradient,
                        child: Container(
                          decoration: BoxDecoration(
                           color: const Color.fromARGB(66, 224, 220, 220),
                            borderRadius: BorderRadius.circular(
                              Sizes().height(context, 0.01),
                            ),
                          ),
                          height: Sizes().height(context, 0.1),
                          width: Sizes().width(context, 0.20),
                        ),
                      ),

                      Space().width(context,0.04),
                       Shimmer(
                        gradient: gradient,
                        child: Container(
                          decoration: BoxDecoration(
                           color: const Color.fromARGB(66, 224, 220, 220),
                            borderRadius: BorderRadius.circular(
                              Sizes().height(context, 0.01),
                            ),
                          ),
                          height: Sizes().height(context, 0.1),
                          width: Sizes().width(context, 0.20),
                        ),
                      ),
                      Space().width(context,0.04),
                       Shimmer(
                        gradient: gradient,
                        child: Container(
                          decoration: BoxDecoration(
                           color: const Color.fromARGB(66, 224, 220, 220),
                            borderRadius: BorderRadius.circular(
                              Sizes().height(context, 0.01),
                            ),
                          ),
                          height: Sizes().height(context, 0.1),
                          width: Sizes().width(context, 0.20),
                        ),
                      ),
                ],
              ),
             Space().height(context,0.02),
              //map
              Shimmer(
                gradient: gradient,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(66, 224, 220, 220),
                    borderRadius: BorderRadius.circular(
                      Sizes().height(context, 0.005),
                    ),
                  ),
                  height: Sizes().height(context, 0.20),
                  width: Sizes().width(context, 1.0),
                ),
              ),
            
             Space().height(context,0.02),
              //amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer(
                    gradient: gradient,
                    child: Container(
                      decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 224, 220, 220),
                        borderRadius: BorderRadius.circular(
                          Sizes().height(context, 0.005),
                        ),
                      ),
                      height: Sizes().height(context, 0.02),
                      width: Sizes().width(context, 0.2),
                    ),
                  ),
            
                  //button
                  Shimmer(
                    gradient: gradient,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(66, 224, 220, 220),
                        borderRadius: BorderRadius.circular(
                          Sizes().height(context, 0.02),
                        ),
                      ),
                      height: Sizes().height(context, 0.05),
                      width: Sizes().width(context, 0.35),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
