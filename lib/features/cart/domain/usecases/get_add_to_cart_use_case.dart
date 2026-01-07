import 'package:dartz/dartz.dart';
 import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../../core/feature/domain/use_cases/use_case.dart';

  import '../../data/models/params/cart_item_param.dart';
import '../repositories/cart_repository.dart';





class AddToCart implements  UseCase<Unit,CartItemParams> {
  final ICartRepository repository;
  AddToCart(this.repository);
  @override
  Future<Either<ErrorEntity, Unit>> call(CartItemParams params) async =>
      repository.addToCart(params );
}

