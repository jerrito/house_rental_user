import 'package:dartz/dartz.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class GetCacheData extends UseCases<User, NoParams> {
  final AuthenticationRepository repository;

  GetCacheData({required this.repository});
  
  @override
  Future<Either<String, User>> call(NoParams params) async{
    return await repository.getCacheData();
  }
}
