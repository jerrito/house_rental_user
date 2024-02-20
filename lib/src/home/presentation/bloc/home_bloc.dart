import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/home/domain/entities/house.dart';
import 'package:house_rental/src/home/domain/usecases/get_all_houses.dart';
import 'package:house_rental/src/home/domain/usecases/get_house.dart';
import 'package:house_rental/src/home/domain/usecases/get_profile_camera.dart';
import 'package:house_rental/src/home/domain/usecases/get_profile_gallery.dart';
import 'package:house_rental/src/home/domain/usecases/up_load_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProfileCamera getProfileCamera;
  final GetProfileGallery getProfileGallery;
  final GetAllHouses getAllHouses;
  final GetHouse getHouse;
  HomeBloc(
      {required this.getProfileCamera,
      required this.getProfileGallery,
      required this.getAllHouses,
      required this.getHouse})
      : super(HomeInitState()) {
   

    

    on<GetAllHousesEvent>(((event, emit) async {
      emit(GetALLHousesLoading());

      final response = await getAllHouses.call(event.params);

      emit(
        response.fold(
          (error) => GetAllHousesError(errorMessage: error),
          (response) => GetAllHousesLoaded(houseDetail: response.docs),
        ),
      );
    }));

    on<GetHouseEvent>(((event, emit) async {
      emit(GetHouseLoading());

      final response = await getHouse.call(event.params);

      emit(
        response.fold(
          (error) => GetHouseError(errorMessage: error),
          (response) => GetHouseLoaded(houseDetail: response.data()),
        ),
      );
    }));
  }

  Future<bool> launchUrl(String type, String number) async {
    return await launcher.launchUrl(Uri(
      scheme: type,
      path: number,
    ));
  }
}
