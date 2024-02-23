import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:house_rental/core/size/sizes.dart";
import "package:house_rental/core/spacing/whitspacing.dart";
import "package:shimmer/shimmer.dart";

class HouseShimmer extends StatelessWidget {
  const HouseShimmer({super.key});

  final gradient=const LinearGradient(
            colors: [
              Color.fromARGB(66, 224, 220, 220),
              Color.fromARGB(221, 143, 141, 141),
            ]);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          
        Space().height(context,0.05),
      Padding(
     padding:  EdgeInsets.symmetric(
        horizontal:Sizes().width(context, 0.04)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
            //search 
            Shimmer(
              gradient: gradient,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
            color: const Color.fromARGB(66, 224, 220, 220),
                                        borderRadius: BorderRadius.circular(
                      Sizes().height(context, 0.015),
                    ),
                  ),
                  height: Sizes().height(context, 0.05),
                  width: Sizes().width(context, 0.758),
                ),
              ),
            ),
            
            //menu icon
         Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(66, 224, 220, 220),
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.005),
              ),
            ),
            height: Sizes().height(context, 0.05),
            width: Sizes().width(context, 0.08),
          ),
        ),
          ],
        ),
      ),
          Space().height(context,0.02),
      //category row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
             height: Sizes().height(context, 0.05),
             width: Sizes().width(context, 0.20),
           ),
                  ),
                  Shimmer(
           gradient: gradient,
           child: Container(
             decoration: BoxDecoration(
               color: const Color.fromARGB(66, 224, 220, 220),
               borderRadius: BorderRadius.circular(
                 Sizes().height(context, 0.005),
               ),
             ),
             height: Sizes().height(context, 0.05),
             width: Sizes().width(context, 0.20),
           ),
                  ),
                  Shimmer(
           gradient: gradient,
           child: Container(
             decoration: BoxDecoration(
               color: const Color.fromARGB(66, 224, 220, 220),
               borderRadius: BorderRadius.circular(
                 Sizes().height(context, 0.005),
               ),
             ),
             height: Sizes().height(context, 0.05),
             width: Sizes().width(context, 0.20),
           ),
                  ),
                  Shimmer(
           gradient: gradient,
           child: Container(
             decoration: BoxDecoration(
               color: const Color.fromARGB(66, 224, 220, 220),
               borderRadius: BorderRadius.circular(
                 Sizes().height(context, 0.005),
               ),
             ),
             height: Sizes().height(context, 0.05),
             width: Sizes().width(context, 0.20),
           ),
                  ),
        ],
      ),
          Space().height(context,0.02),
       //house container
       CarouselSlider.builder(
        itemCount: 4,
        options: CarouselOptions(
                                height: Sizes().height(context,0.342),
                                 viewportFraction: 0.6),
         itemBuilder: (context,index,itemCount) {
           return Shimmer(
            gradient: gradient,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(66, 224, 220, 220),
                borderRadius: BorderRadius.circular(
                  Sizes().height(context, 0.05),
                ),
              ),
              height: Sizes().height(context, 0.342),
              width: Sizes().width(context, 0.444),
            ),
                       );
         }
       ),
          Space().height(context,0.02),
      //text row
       Padding(
        padding:  EdgeInsets.symmetric(
        horizontal:Sizes().width(context, 0.04)),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
            
            //best for you
             Shimmer(
              gradient: gradient,
              child: Container(
                color: const Color.fromARGB(66, 224, 220, 220),                
                height: Sizes().height(context, 0.01),
                width: Sizes().width(context, 0.12),
              ),
                     ),
                 
                     //see more
             Shimmer(
              gradient: gradient,
              child: Container(
                color: const Color.fromARGB(66, 224, 220, 220),                
                height: Sizes().height(context, 0.01),
                width: Sizes().width(context, 0.12),
              ),
                     ),
           ],
         ),
       ),
       
          Space().height(context,0.02),
       //house listTiles
       Flexible(
         child: Padding(
           padding:  EdgeInsets.symmetric(
        horizontal:Sizes().width(context, 0.04)),
           child: ListView.builder(
            itemCount: 5,
             itemBuilder: (context,index) {
               return Padding(
                 padding:  EdgeInsets.only(
                  
                  bottom:Sizes().height(context, 0.01)),
                 child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
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
                        height: Sizes().height(context, 0.12),
                        width: Sizes().width(context, 0.28),
                      ),
                             ),
                    
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                 
                 //house name
                 Shimmer(
                  gradient: gradient,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 224, 220, 220),
                      borderRadius: BorderRadius.circular(
                        Sizes().height(context, 0.005),
                      ),
                    ),
                    height: Sizes().height(context, 0.015),
                    width: Sizes().width(context, 0.18),
                  ),
                             ),
                    Space().height(context,0.005),
                 //amount
                 Shimmer(
                  gradient: gradient,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 224, 220, 220),
                      borderRadius: BorderRadius.circular(
                        Sizes().height(context, 0.005),
                      ),
                    ),
                    height: Sizes().height(context, 0.015),
                    width: Sizes().width(context, 0.2),
                  ),
                             ),
                    
                    Space().height(context,0.005),
                 //bed and bath count
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
                    width: Sizes().width(context, 0.5),
                  ),
                             ),
                        ]
                       )      
                   ],
                 ),
               );
             }
           ),
         ),
       ),
     
        ],
      
    );
  }
}

class HouseContainerShimmer extends StatelessWidget {
  const HouseContainerShimmer({super.key});
 final gradient=const LinearGradient(
            colors: [
              Color.fromARGB(66, 224, 220, 220),
              Color.fromARGB(221, 143, 141, 141),
            ]);
  @override
  Widget build(BuildContext context) {
   
    return  //house container
       CarouselSlider.builder(
        itemCount: 4,
        options: CarouselOptions(
                                height: Sizes().height(context,0.342),
                                 viewportFraction: 0.6),
         itemBuilder: (context,index,itemCount) {
           return Shimmer(
            gradient: gradient,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(66, 224, 220, 220),
                borderRadius: BorderRadius.circular(
                  Sizes().height(context, 0.05),
                ),
              ),
              height: Sizes().height(context, 0.342),
              width: Sizes().width(context, 0.444),
            ),
                       );
         }
       );
  }
}

class HouseListShimmer extends StatelessWidget {
  const HouseListShimmer({super.key});
 final gradient=const LinearGradient(
            colors: [
              Color.fromARGB(66, 224, 220, 220),
              Color.fromARGB(221, 143, 141, 141),
            ]);
  @override
  Widget build(BuildContext context) {
    return  //house listTiles
       Flexible(
         child: Padding(
           padding:  EdgeInsets.symmetric(
        horizontal:Sizes().width(context, 0.04)),
           child: ListView.builder(
            itemCount: 5,
             itemBuilder: (context,index) {
               return Padding(
                 padding:  EdgeInsets.only(
                  
                  bottom:Sizes().height(context, 0.01)),
                 child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
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
                        height: Sizes().height(context, 0.12),
                        width: Sizes().width(context, 0.28),
                      ),
                             ),
                    
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                 
                 //house name
                 Shimmer(
                  gradient: gradient,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 224, 220, 220),
                      borderRadius: BorderRadius.circular(
                        Sizes().height(context, 0.005),
                      ),
                    ),
                    height: Sizes().height(context, 0.015),
                    width: Sizes().width(context, 0.18),
                  ),
                             ),
                    Space().height(context,0.005),
                 //amount
                 Shimmer(
                  gradient: gradient,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 224, 220, 220),
                      borderRadius: BorderRadius.circular(
                        Sizes().height(context, 0.005),
                      ),
                    ),
                    height: Sizes().height(context, 0.015),
                    width: Sizes().width(context, 0.2),
                  ),
                             ),
                    
                    Space().height(context,0.005),
                 //bed and bath count
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
                    width: Sizes().width(context, 0.5),
                  ),
                             ),
                        ]
                       )      
                   ],
                 ),
               );
             }
           ),
         ),);
  }
}