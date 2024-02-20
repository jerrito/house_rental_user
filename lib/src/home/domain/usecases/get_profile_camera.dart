// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/home/domain/repository/home_repository.dart';
import 'package:image_picker/image_picker.dart';

class GetProfileCamera extends UseCases<XFile, NoParams> {
  final HomeRepository repository;
  GetProfileCamera({
    required this.repository,
  });
  @override
  Future<Either<String, XFile>> call(NoParams params) async {
    return await repository.getProfileImageCamera();
  }
}
