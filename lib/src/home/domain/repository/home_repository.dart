import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:house_rental/src/home/domain/entities/house.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeRepository {
  Future<Either<String, XFile>> getProfileImageGallery();
  Future<Either<String, XFile>> getProfileImageCamera();
  Future<Either<String, String>> upLoadImage(Map<String, dynamic> params);
  Future<Either<String, QuerySnapshot<HouseDetail>>> getAllHouses(
      Map<String, dynamic> params);
      Future<Either<String, QuerySnapshot<HouseDetail>>> getCategoryHouses(
      Map<String, dynamic> params);
  Future<Either<String, DocumentSnapshot<HouseDetail>>> editHouse(Map<String, dynamic> params);
}
