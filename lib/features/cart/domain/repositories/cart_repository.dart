import 'package:dartz/dartz.dart';
import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../../core/feature/domain/repositories/irepository.dart';
 import '../../data/models/params/cart_item_param.dart';
import '../entities/category.dart';


abstract class ICartRepository extends IRepository {
   Future<Either<ErrorEntity, GetCartItemsEntity>> getCart();
  Future<Either<ErrorEntity, Unit>> addToCart(CartItemParams item);
  Future<Either<ErrorEntity, Unit>> removeFromCart(int productId);
  Future<Either<ErrorEntity, Unit>> updateQuantity(int productId, int quantity);
  Future<Either<ErrorEntity, Unit>> clearCart();
}
