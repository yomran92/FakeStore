import 'package:dartz/dartz.dart';
import 'package:fakestore/features/cart/data/models/response/cart_item_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../products/data/models/response/get_all_product_model.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/cart_repository.dart';
 import '../datasources/cart_local_data_source.dart';
import '../models/params/cart_item_param.dart';
import '../models/response/get_cart_items_model.dart';

 class CartRepository extends ICartRepository {
   CartLocalDataSource localDataSource;

   CartRepository(this.localDataSource);




  @override
  Future<Either<ErrorEntity, Unit>> addToCart(CartItemParams item) async{
    try {
       final productModel = ProductModel(
        id: item.product.id,
        title: item.product.title,
        price: item.product.price,
        description: item.product.description,
        category: item.product.category,
        image: item.product.image,
        rating: RatingModel(
            rate: item.product.rating.rate, count: item.product.rating.count),
      );
      final model = CartItemModel(
        product: productModel,
        quantity: item.quantity,
      );

      await localDataSource.addToCart(model);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorEntity.fromException(e as AppException));
    }
  }

  @override
  Future<Either<ErrorEntity, Unit>> clearCart() {
    // TODO: implement clearCart
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorEntity, GetCartItemsEntity>> getCart() async {
    try {
      final GetCartItemsModel remote = await localDataSource.getCart();
      return Right(remote.toEntity());
    } on AppException catch (e, st) {

      return Left(ErrorEntity.fromException(e));
    }
  }

  @override
  Future<Either<ErrorEntity, Unit>> removeFromCart(int productId)async {
    try {
      await localDataSource.removeFromCart(productId);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorEntity(errorMessage:'Cache Error'));
    }
  }

  @override
  Future<Either<ErrorEntity, Unit>> updateQuantity(int productId, int quantity) async{
    try {
      await localDataSource.updateQuantity(productId, quantity);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorEntity(errorMessage:'Cache Error'));
    }
  }

}
