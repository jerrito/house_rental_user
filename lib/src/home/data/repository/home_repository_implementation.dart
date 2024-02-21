import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:house_rental/core/network_info.dart/network_info.dart';
import 'package:house_rental/src/home/data/data_source/localds.dart';
import 'package:house_rental/src/home/data/data_source/remote_ds.dart';
import 'package:house_rental/src/home/domain/entities/house.dart';
import 'package:house_rental/src/home/domain/repository/home_repository.dart';
import 'package:image_picker/image_picker.dart';

class HomeRepositoryImplementation implements HomeRepository {
  final HomeLocalDatasource homeLocalDatasource;
  final NetworkInfo networkInfo;
  final HomeRemoteDatasource homeRemoteDatasource;

  HomeRepositoryImplementation({
    required this.networkInfo,
    required this.homeLocalDatasource,
    required this.homeRemoteDatasource,
  });
  @override
  Future<Either<String, XFile>> getProfileImageGallery() async {
    try {
      final response = await homeLocalDatasource.getProfileImageGallery();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, XFile>> getProfileImageCamera() async {
    try {
      final response = await homeLocalDatasource.getProfileImageCamera();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> upLoadImage(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await homeLocalDatasource.upLoadImage(params);
        print(response);
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, QuerySnapshot<HouseDetail>>> getAllHouses(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await homeRemoteDatasource.getAllHouses(params);

        return Right(response);
      } catch (e) {
        return Left(
          e.toString(),
        );
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

   @override
  Future<Either<String, QuerySnapshot<HouseDetail>>> getCategoryHouses(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await homeRemoteDatasource.getCategoryHouses(params);

        return Right(response);
      } catch (e) {
        return Left(
          e.toString(),
        );
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, DocumentSnapshot<HouseDetail>>> editHouse(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {

      try {
        final response = await homeRemoteDatasource.getHouse(params);

        return Right(response);
      } catch (e) {
        return Left(
          e.toString(),
        );
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }
}
