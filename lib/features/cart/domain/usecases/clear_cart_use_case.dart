
import 'package:dartz/dartz.dart';
 import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../../core/feature/domain/use_cases/use_case.dart';

import '../../data/models/params/update_cart_param.dart';
import '../repositories/cart_repository.dart';






class ClearCart implements UseCase<Unit, NoParams> {
  final ICartRepository repository;
  ClearCart(this.repository);
  @override
  Future<Either<ErrorEntity, Unit>> call(NoParams params) async => repository.clearCart();
}

