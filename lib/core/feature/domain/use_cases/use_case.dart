
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/params/params_model.dart';
import '../entities/entity.dart';
import '../entities/error_entity.dart';

abstract class UseCase<DataEntity extends Entity, Params extends ParamsModel> {
  Future<Either<ErrorEntity, DataEntity>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
