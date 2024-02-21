part of 'home_bloc.dart';

class HomeState {}

class HomeInitState extends HomeState {}





class GetALLHousesLoading extends HomeState {}

class GetAllHousesError extends HomeState {
  final String errorMessage;
  GetAllHousesError({required this.errorMessage});
}

class GetAllHousesLoaded extends HomeState {
  final List<QueryDocumentSnapshot<HouseDetail>> houseDetail;
  GetAllHousesLoaded({required this.houseDetail});
}


class GetHouseLoading extends HomeState {}

class GetHouseError extends HomeState {
  final String errorMessage;
  GetHouseError({required this.errorMessage});
}

class GetHouseLoaded extends HomeState {
  final HouseDetail? houseDetail;
  GetHouseLoaded({required this.houseDetail});
}

class GetCategoryAllHousesLoading extends HomeState {}

class GetCategoryAllHousesError extends HomeState {
  final String errorMessage;
  GetCategoryAllHousesError({required this.errorMessage});
}

class GetCategoryAllHousesLoaded extends HomeState {
  final List<QueryDocumentSnapshot<HouseDetail>> houseDetail;
  GetCategoryAllHousesLoaded({required this.houseDetail});
}