import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/home/domain/entities/house.dart';
import 'package:house_rental/src/home/domain/repository/home_repository.dart';

class GetCategoryAllHouses extends UseCases<QuerySnapshot<HouseDetail>,Map<String,dynamic>>{
  final HomeRepository repository;

  GetCategoryAllHouses({required this.repository});
  @override
  Future<Either<String, QuerySnapshot<HouseDetail>>> call(Map<String, dynamic> params) async{
  
    return await repository.getCategoryHouses(params);
  }
  
}