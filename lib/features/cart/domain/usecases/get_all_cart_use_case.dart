import 'package:dartz/dartz.dart';
 import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../../core/feature/domain/use_cases/use_case.dart';
import '../entities/category.dart';

  import '../repositories/cart_repository.dart';




class GetCart implements UseCaseNoParam<GetCartItemsEntity> {
  final ICartRepository repository;
  GetCart(this.repository);
  @override
  Future<Either<ErrorEntity, GetCartItemsEntity>> call() async =>
      repository.getCart();
}




