import 'package:dartz/dartz.dart';
import 'package:fakestore/features/category/data/models/params/get_all_category.dart';
import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../../core/feature/domain/repositories/irepository.dart';
 import '../../data/models/params/cart_item_param.dart';
import '../../data/models/response/cart_item_model.dart';
import '../entities/category.dart';


abstract class ICartRepository extends IRepository {
   Future<Either<ErrorEntity, GetCartItemsEntity>> getCart();
  Future<Either<ErrorEntity, Unit>> addToCart(CartItemParams item);
  Future<Either<ErrorEntity, Unit>> removeFromCart(int productId);
  Future<Either<ErrorEntity, Unit>> updateQuantity(int productId, int quantity);
  Future<Either<ErrorEntity, Unit>> clearCart();
}
