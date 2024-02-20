import 'package:equatable/equatable.dart';
class HouseDetail extends Equatable {
  final String? houseName, description, category;
  final num? amount, bedRoomCount, bathRoomCount;
  final bool? isAvailable;
   final HouseLocation? houseLocation;
   final Owner? owner;
  final List<String>? images;

  const HouseDetail({
    required this.category,
    required this.owner,
    required this.houseName,
    required this.description,
    required this.amount,
    required this.images,
    required this.bedRoomCount,
    required this.isAvailable,
    required this.bathRoomCount,
    required this.houseLocation,

  });

  @override
  List<Object?> get props => [
        houseName,
        description,
        owner,
        amount,
        bedRoomCount,
        bathRoomCount,
        images,
        isAvailable,
        houseLocation,
        category
      ];
}

class HouseLocation extends Equatable {
  final String? formatedAddress;
  final num? lat, lng;

  const HouseLocation(
      {required this.formatedAddress, required this.lat, required this.lng});

  @override
  List<Object?> get props => [formatedAddress, lat, lng];
}



class Owner extends Equatable {
  final String? firstName,
      lastName,
      phoneNumber,
      profileURL,
      email,
      houseGPSAddress,
      townORCity,
      role;

  const Owner({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileURL,
    required this.email,
    required this.houseGPSAddress,
    required this.townORCity,
    required this.role,
  });


  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phoneNumber,
        profileURL,
        email,
        houseGPSAddress,
        townORCity,
        role,
      ];

       Map<String,dynamic> toMap()=>
      {
        "first_name":firstName,
        "last_name":lastName,
        "phone_number":phoneNumber,
        "profile_URL":profileURL,
        "email":email,
        "house_GPS_address":houseGPSAddress,
        "town_or_city":townORCity,
        "role":role,
      };
}
