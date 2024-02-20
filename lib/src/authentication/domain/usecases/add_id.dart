import 'package:dartz/dartz.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class AddId extends UseCases<void, Map<String, dynamic>> {
  final AuthenticationRepository repository;

  AddId({required this.repository});
  @override
  Future<Either<String, void>> call(
      Map<String, dynamic> params) async {
    return await repository.addId(params);
  }
}
