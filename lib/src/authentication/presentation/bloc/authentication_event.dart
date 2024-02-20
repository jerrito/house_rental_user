part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class SignupEvent extends AuthenticationEvent {
  final Map<String, dynamic> users;

  const SignupEvent({required this.users});
}

final class SignupCompleteEvent extends AuthenticationEvent {
  const SignupCompleteEvent();
}

final class SignupLoadingEvent extends AuthenticationEvent {
  const SignupLoadingEvent();
}

final class SignupErrorEvent extends AuthenticationEvent {
  final String error;
  const SignupErrorEvent({required this.error});
}

final class SigninEvent extends AuthenticationEvent {
  final Map<String, dynamic> users;

  const SigninEvent({required this.users});
}

final class SigninCompleteEvent extends AuthenticationEvent {
  const SigninCompleteEvent();
}

final class SigninLoadingEvent extends AuthenticationEvent {
  const SigninLoadingEvent();
}

final class SigninErrorEvent extends AuthenticationEvent {
  final String error;
  const SigninErrorEvent({required this.error});
}

final class PhoneNumberErrorEvent extends AuthenticationEvent {
  final String error;
  const PhoneNumberErrorEvent({required this.error});
}

final class PhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumber;

  const PhoneNumberEvent({required this.phoneNumber});
}

final class CodeSentEvent extends AuthenticationEvent {
  final String verificationId;
  final int forceResendingToken;

  const CodeSentEvent({
    required this.forceResendingToken,
    required this.verificationId,
  });
}

final class VerificationCompleteEvent extends AuthenticationEvent {
  final auth.PhoneAuthCredential phoneAuthCredential;
  const VerificationCompleteEvent({required this.phoneAuthCredential});
}

final class VerifyOTPEvent extends AuthenticationEvent {
  final auth.PhoneAuthCredential params;

  const VerifyOTPEvent({required this.params});
}

final class GetCacheDataEvent extends AuthenticationEvent {
  const GetCacheDataEvent();
}

final class UpdateUserEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;
  const UpdateUserEvent({required this.params});
}

final class AddIdEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;
  const AddIdEvent({required this.params});
}

final class PhoneNumberLoginEvent extends AuthenticationEvent {
  final String phoneNumber;
  const PhoneNumberLoginEvent({required this.phoneNumber});
}


class CheckPhoneNumberEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;
  const CheckPhoneNumberEvent({required this.params});
}

class GetUserEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;
  const GetUserEvent({required this.params});
}


class GetProfileGalleryEvent extends AuthenticationEvent {
  final NoParams params;
 const GetProfileGalleryEvent({required this.params});
}

class GetProfileCameraEvent extends AuthenticationEvent {
  final NoParams params;
 const GetProfileCameraEvent({required this.params});
}

class UpLoadImageEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;
  UpLoadImageEvent({required this.params});
}