import 'package:dartz/dartz.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/home/domain/repository/home_repository.dart';

class UpLoadImage extends UseCases<String, Map<String, dynamic>> {
  final HomeRepository repository;

  UpLoadImage({required this.repository});

  @override
  Future<Either<String, String>> call(Map<String, dynamic> params) async {
    return await repository.upLoadImage(params);
  }
}
