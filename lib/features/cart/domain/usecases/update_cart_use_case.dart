
import 'package:dartz/dartz.dart';
 import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../../core/feature/domain/use_cases/use_case.dart';

import '../../data/models/params/update_cart_param.dart';
import '../repositories/cart_repository.dart';






class UpdateCartQuantity implements UseCase<Unit, UpdateCartQuantityParams> {
  final ICartRepository repository;
  UpdateCartQuantity(this.repository);
  @override
  Future<Either<ErrorEntity, Unit>> call(UpdateCartQuantityParams params) async => repository.updateQuantity(params.productId, params.quantity);
}


