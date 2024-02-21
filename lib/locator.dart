import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:house_rental/core/firebase/firebase_service.dart';
import 'package:house_rental/core/network_info.dart/network_info.dart';
import 'package:house_rental/src/authentication/data/data_source/local_ds.dart';
import 'package:house_rental/src/authentication/data/data_source/remote_ds.dart';
import 'package:house_rental/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:house_rental/src/authentication/domain/usecases/add_id.dart';
import 'package:house_rental/src/authentication/domain/usecases/check_phone_number.dart';
import 'package:house_rental/src/authentication/domain/usecases/get_cache_data.dart';
import 'package:house_rental/src/authentication/domain/usecases/get_user.dart';
import 'package:house_rental/src/authentication/domain/usecases/phone_number_login.dart';
import 'package:house_rental/src/authentication/domain/usecases/signin.dart';
import 'package:house_rental/src/authentication/domain/usecases/signup.dart';
import 'package:house_rental/src/authentication/domain/usecases/update_user.dart';
import 'package:house_rental/src/authentication/domain/usecases/verify_number.dart';
import 'package:house_rental/src/authentication/domain/usecases/verify_otp.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/home/data/data_source/localds.dart';
import 'package:house_rental/src/home/data/data_source/remote_ds.dart';
import 'package:house_rental/src/home/data/repository/home_repository_implementation.dart';
import 'package:house_rental/src/home/domain/repository/home_repository.dart';
import 'package:house_rental/src/home/domain/usecases/get_all_houses.dart';
import 'package:house_rental/src/home/domain/usecases/get_category_house.dart';
import 'package:house_rental/src/home/domain/usecases/get_house.dart';
import 'package:house_rental/src/home/domain/usecases/get_profile_camera.dart';
import 'package:house_rental/src/home/domain/usecases/get_profile_gallery.dart';
import 'package:house_rental/src/home/domain/usecases/up_load_image.dart';
import 'package:house_rental/src/home/presentation/bloc/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  //bloc

  locator.registerFactory(
    () => AuthenticationBloc(
        firebaseAuth: locator(),
        signup: locator(),
        verifyNumber: locator(),
        verifyOTP: locator(),
        getCacheData: locator(),
        signin: locator(),
        firebaseService: locator(),
        updateUser: locator(),
        addId: locator(),
        verifyPhoneNumberLogin: locator(),
        checkPhoneNumberChange: locator(),
        getUser: locator(),
        getProfileCamera: locator(),
        getProfileGallery: locator(),
        upLoadImage: locator(),
        ),
  );

  locator.registerFactory(
    () => HomeBloc(
        getProfileCamera: locator(),
        getProfileGallery: locator(),
        getAllHouses: locator(),
        getHouse: locator(),
        getCategoryAllHouses: locator()
        ),
  );

  //usecases

  locator.registerLazySingleton(
    () => Signup(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => CheckPhoneNumberChange(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetCategoryAllHouses(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetUser(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetAllHouses(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => AddId(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => Signin(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => FirebaseAuth.instance,
  );

  locator.registerLazySingleton(
    () => VerifyPhoneNumber(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => VerifyPhoneNumberLogin(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => VerifyOTP(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetCacheData(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => UpdateUser(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetProfileCamera(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetProfileGallery(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => UpLoadImage(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetHouse(
      repository: locator(),
    ),
  );

  //repository

  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      firebaseService: locator(),
      networkInfo: locator(),
      remoteDatasource: locator(),
      localDatasource: locator(),
    ),
  );

  locator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImplementation(
        networkInfo: locator(),
        homeLocalDatasource: locator(),
        homeRemoteDatasource: locator()),
  );
  //remoteds

  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      dataConnectionChecker: locator(),
    ),
  );

  locator.registerLazySingleton<AuthenticationLocalDatasource>(
    () => AuhenticationLocalDataSourceImpl(
      sharedPreferences: locator(),
    ),
  );

  locator.registerLazySingleton<HomeLocalDatasource>(
    () => HomeLocalDatasourceImpl(),
  );

  locator.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatatsourceImpl(),
  );

  final sharedPreference = await SharedPreferences.getInstance();
  locator.registerLazySingleton(
    () => sharedPreference,
  );

  locator.registerLazySingleton<AuthenticationRemoteDatasource>(
    () => AuthenticationRemoteDatasourceImpl(
      localDatasource: locator(),
      firebaseAuth: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => DataConnectionChecker(),
  );

  locator.registerLazySingleton(
    () => FirebaseService(
      firebaseFirestore: locator(),
      firebaseAuth: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => FirebaseFirestore.instance,
  );
}
