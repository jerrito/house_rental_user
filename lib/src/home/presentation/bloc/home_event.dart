part of 'home_bloc.dart';

class HomeEvent {}





class GetAllHousesEvent extends HomeEvent {
  final Map<String, dynamic> params;
  GetAllHousesEvent({required this.params});
}

class GetCategoryAllHousesEvent extends HomeEvent {
  final Map<String, dynamic> params;
  GetCategoryAllHousesEvent({required this.params});
}


class GetHouseEvent extends HomeEvent {
  final Map<String, dynamic> params;
  GetHouseEvent({required this.params});
}