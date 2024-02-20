import 'package:dartz/dartz.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class GetUser extends UseCases<User?, Map<String, dynamic>> {
  final AuthenticationRepository repository;
  GetUser({required this.repository});
  @override
  Future<Either<String, User?>> call(Map<String, dynamic> params) async {
    return await repository.getUser(params);
  }
}
