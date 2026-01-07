import 'package:dartz/dartz.dart';
 import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../../core/feature/domain/use_cases/use_case.dart';

import '../../data/models/params/remove_from_cart_param.dart';
import '../repositories/cart_repository.dart';






class RemoveFromCart implements UseCase<Unit, RemoveFromCartParams> {
  final ICartRepository repository;
  RemoveFromCart(this.repository);
  @override
  Future<Either<ErrorEntity, Unit>> call(RemoveFromCartParams params) async => repository
      .removeFromCart(params.productId);
}

