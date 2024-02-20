import 'package:firebase_auth/firebase_auth.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class VerifyPhoneNumberLogin {
  final AuthenticationRepository repository;

  VerifyPhoneNumberLogin({required this.repository});

  Future<void> verifyPhoneNumberLogin(
      String phoneNumber,
      Function(String verificationId, int? resendToken) onCodeSent,
      Function(PhoneAuthCredential phoneAuthCredential) onCompleted,
      Function(FirebaseAuthException) onFailed) async {
    await repository.verifyPhoneNumberLogin(
      phoneNumber,
      onCodeSent,
      onCompleted,
      onFailed,
    );
  }
}
