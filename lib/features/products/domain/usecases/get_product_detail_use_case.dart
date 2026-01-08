import 'package:dartz/dartz.dart';
import 'package:fakestore/features/products/data/models/response/get_all_product_model.dart';
import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../../core/feature/domain/use_cases/use_case.dart';
import '../../data/models/params/get_product_by_id.dart';
import '../repositories/product_repository.dart';

class GetProductDetailUseCase extends UseCase<ProductModel, GetProductByIdParams> {
  final IProductRepository repository;

  GetProductDetailUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, ProductModel>> call(GetProductByIdParams params) async {
    return await repository.getProductDetail(params);
  }
}
