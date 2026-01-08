import 'package:dartz/dartz.dart';
import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../../core/feature/domain/repositories/irepository.dart';
import '../../data/models/params/get_all_product.dart';
import '../../data/models/params/get_product_by_id.dart';
import '../../data/models/response/get_all_product_model.dart';
import '../entities/product.dart';

abstract class IProductRepository extends IRepository {
  Future<Either<ErrorEntity, GetAllProductEntity>> getAllProducts(
    GetAllProductParams model,
  );
  Future<Either<ErrorEntity, ProductModel>> getProductDetail(GetProductByIdParams model);
}
