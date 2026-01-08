
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/entity.dart';
import '../entities/error_entity.dart';

// abstract class UseCase<DataEntity extends Entity, Params extends ParamsModel> {
//   Future<Either<ErrorEntity, DataEntity>> call(Params params);
// }
abstract class UseCaseNoParam<DataEntity extends Entity> {
  Future<Either<ErrorEntity, DataEntity>> call();
}
abstract class UseCase<Type, Params> {
  Future<Either<ErrorEntity, Type>> call(Params params);
}
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
//
