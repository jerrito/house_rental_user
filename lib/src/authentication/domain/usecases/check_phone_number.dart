import 'package:dartz/dartz.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class CheckPhoneNumberChange extends UseCases<bool, Map<String, dynamic>> {
  final AuthenticationRepository repository;
  CheckPhoneNumberChange({required this.repository});
  @override
  Future<Either<String, bool>> call(Map<String, dynamic> params) async {
    return await repository.checkPhoneNumberChange(params);
  }
}
