import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';

class FirebaseService {
  final auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseService(
      {required this.firebaseFirestore, required this.firebaseAuth});
  final usersRef = FirebaseFirestore.instance
      .collection('houseRentalAccount')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toMap(),
      );
  String idGet = "";
  Future<UserModel?> getUser({required String phoneNumber}) async {
    UserModel? result;

    return await usersRef
        .where("phone_number", isEqualTo: phoneNumber)
        .get()
        .then((snapshot) {
      var userSnapShot = snapshot.docs;

      UserModel? data;
      if (userSnapShot.isNotEmpty) {
        data = userSnapShot.first.data();
        idGet = data.id!;
        idGet = userSnapShot.first.id;
        //data.id=
        // print(data.id);
      }

      // var status = QueryStatus.successful;

      result = data;
      return result;
    }).catchError((error) {
      if (kDebugMode) {
        print("Failed to get user: $error");
      }

      var errorMsg = error;
      result = errorMsg;

      return result;
    });
  }

  Future<DocumentReference<UserModel>?> saveUser(
      {required UserModel user}) async {
    // UserModel? result;

    //
    return await usersRef.add(user);
  }

  Future<void> updateUser({required User user}) async {
   // print(user.id);

    //
   return await usersRef.doc(user.id).update(user.toMap());
   
    //return result;
  }

  Future<void> phoneSignIn(Map<String, dynamic> params) async {
    await firebaseAuth.verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      phoneNumber: params["phoneNumber"],
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: _onCodeTimeout,
    );
  }

  _onVerificationCompleted(auth.PhoneAuthCredential authCredential) async {}

  _onVerificationFailed(auth.FirebaseAuthException exception) async {}

  _onCodeSent(String verificationId, int? forceResendingToken) async {}

  _onCodeTimeout(String timeout) async {
    return null;
  }
}
