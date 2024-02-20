import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_rental/src/home/data/models/house_model.dart';

abstract class HomeRemoteDatasource {
  Future<QuerySnapshot<HouseDetailModel>> getAllHouses(
      Map<String, dynamic> params);
  Future<DocumentSnapshot<HouseDetailModel>> getHouse(
      Map<String, dynamic> params);
  Future<QuerySnapshot<HouseDetailModel>> getCategoryHouses(
      Map<String, dynamic> params);
}

class HomeRemoteDatatsourceImpl extends HomeRemoteDatasource {
  @override
  Future<QuerySnapshot<HouseDetailModel>> getAllHouses(
      Map<String, dynamic> params) async {
    final houseReference = await FirebaseFirestore.instance
        .collection("houses")
        // .snapshots()
        // .forEach((element) {
        //   element.docChanges.docs.where((element) => false);
        // })
        // .collection("houses")
        .withConverter<HouseDetailModel>(
          fromFirestore: (snapshot, _) =>
              HouseDetailModel.fromJson(snapshot.data()!),
          toFirestore: (house, _) => house.toMap(),
        )
        .get();

    return houseReference;
  }

  @override
  Future<DocumentSnapshot<HouseDetailModel>> getHouse(
      Map<String, dynamic> params) async {
    final houseReference = await FirebaseFirestore.instance
        .collection("houses")
        .withConverter<HouseDetailModel>(
          fromFirestore: (snapshot, _) =>
              HouseDetailModel.fromJson(snapshot.data()!),
          toFirestore: (house, _) => house.toMap(),
        )
        .doc(params["id"])
        .get();

    return houseReference;
  }
  
  @override
  Future<QuerySnapshot<HouseDetailModel>> getCategoryHouses(Map<String, dynamic> params) {
    // TODO: implement getCategoryHouses
    throw UnimplementedError();
  }
}
