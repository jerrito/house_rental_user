import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:house_rental/src/authentication/data/data_source/local_ds.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRemoteDatasource {
  Future<UserModel?> signin(Map<String, dynamic> params);
  Future<DocumentReference<UserModel>?> signup(Map<String, dynamic> params);
  Future<auth.User> verifyOTP(auth.PhoneAuthCredential credential);
  Future<void> updateUser(Map<String, dynamic> params);
  Future<void> addId(Map<String, dynamic> params);

  Future<bool> checkPhoneNumberChange(Map<String, dynamic> params);

}

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  final auth.FirebaseAuth firebaseAuth;
  final AuthenticationLocalDatasource localDatasource;
  AuthenticationRemoteDatasourceImpl(
      {required this.localDatasource, required this.firebaseAuth});
  final usersRef = FirebaseFirestore.instance
      .collection('houseRentalAccount')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toMap(),
      );
  @override
  Future<UserModel> signin(Map<String, dynamic> params) async {
    // UserModel result;

    return await usersRef
        .where("email", isEqualTo: params["email"])
        .where("password", isEqualTo: params["password"])
        .get()
        .then((snapshot) {
      var userSnapShot = snapshot.docs;
      return userSnapShot.first.data();
    });
  }

  @override
  Future<DocumentReference<UserModel>?> signup(
      Map<String, dynamic> params) async {
    final response = usersRef.add(UserModel.fromJson(params));
    
    return response;
  }

  @override
  Future<auth.User> verifyOTP(auth.PhoneAuthCredential credential) async {
    final response = await firebaseAuth.signInWithCredential(credential);

    if (kDebugMode) {
      print(response.user?.uid);
    }

    return response.user!;
  }

  @override
  Future<void> updateUser(Map<String, dynamic> params) async {
    final data = usersRef.doc(params["id"]);
    await data.update(params);

    await data.get().then((value) {
      localDatasource.cacheUserData(value.data()!);
    });
  }

  @override
  Future<void> addId(Map<String, dynamic> params) async {
    await usersRef
        .where("phone_number", isEqualTo: params["phone_number"])
        .get()
        .then((value) async {
      var userData = value.docs.first;

      User? data;

      data = userData.data();
      data.id = userData.id;
      data.uid ??= params["uid"];
     
      //localDatasource.cacheUserData(UserModel.fromJson(data.toMap()));

      await usersRef.doc(userData.id).update({"id": userData.id,"uid":data.uid ?? params["uid"]});
      await localDatasource.cacheUserData(UserModel.fromJson(data.toMap()));
     

     
      //return userData.data();
      //return value;
    });
  }
  
  @override
  Future<bool> checkPhoneNumberChange(Map<String, dynamic> params) async {
    UserModel? owner;
    await usersRef
        .where("phone_number", isEqualTo: params["start_number"])
        .get()
        .then((value) async {
      var userData = value.docs.first;
      owner = userData.data();
    });

    if (params["phone_number"] == owner?.phoneNumber) {
      return true;
    } else {
      return false;
    }
  }
}
