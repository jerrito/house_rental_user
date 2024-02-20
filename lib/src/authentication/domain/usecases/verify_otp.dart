import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class VerifyOTP extends UseCases<User,PhoneAuthCredential> {
  final AuthenticationRepository repository;
   VerifyOTP({required this.repository});
  @override
  Future<Either<String, User>> call(
      PhoneAuthCredential params) async {
    return await repository.verifyOTP(params);
  }
}
