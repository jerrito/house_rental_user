import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCases<Type, Params> {
  Future<Either<String, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}