import 'package:dartz/dartz.dart';
import 'package:fakestore/features/products/data/models/params/get_all_product.dart';
import 'package:fakestore/features/products/data/models/response/get_all_product_model.dart';
import 'package:fakestore/features/products/domain/entities/product.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/params/get_product_by_id.dart';

class ProductRepository extends IProductRepository {
  ProductRemoteDataSource remoteDataSource;

  ProductRepository(this.remoteDataSource);

  @override
  Future<Either<ErrorEntity, GetAllProductEntity>> getAllProducts(
    GetAllProductParams model,
  ) async {
    try {
      final GetAllProductModel remote = await remoteDataSource.getAllProducts(
        model,
      );
      return Right(remote.toEntity());
    } on AppException catch (e) {
      return Left(ErrorEntity.fromException(e));
    }
  }

  @override
  Future<Either<ErrorEntity, ProductModel>> getProductDetail(GetProductByIdParams model) async {
    try {
      final ProductModel remote = await remoteDataSource.getProductDetail(model);
      return Right(remote);
    } on AppException catch (e) {
      return Left(ErrorEntity.fromException(e));
    }
  }
}
