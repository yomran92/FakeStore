import 'package:dartz/dartz.dart';
import 'package:fakestore/features/products/data/models/params/get_all_product.dart';
 import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../../core/feature/domain/use_cases/use_case.dart';
 import '../entities/product.dart';
import '../repositories/product_repository.dart';



class GetAllProductUseCase extends UseCase<GetAllProductEntity, GetAllProductParams> {
  final IProductRepository repository;

  GetAllProductUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetAllProductEntity>> call(
      GetAllProductParams params,
      ) =>
      repository.getAllProducts(params);
}
