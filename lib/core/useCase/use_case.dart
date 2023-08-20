import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart' show Equatable;

import '../api_errors/network_exceptions.dart';

// ignore: one_member_abstracts
abstract class UseCase<Type, Params> {
  Future<Either<NetworkExceptions, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
