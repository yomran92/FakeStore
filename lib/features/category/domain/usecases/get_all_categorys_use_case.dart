import 'package:dartz/dartz.dart';
 import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../../core/feature/domain/use_cases/use_case.dart';
 import '../../data/models/params/get_all_category.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';



class GetAllCategorysUseCase extends UseCase<GetAllCategoryEntity, GetAllCategoryParams> {
  final ICategoryRepository repository;

  GetAllCategorysUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetAllCategoryEntity>> call(
      GetAllCategoryParams params,
      ) =>
      repository.getAllCategorys(params);
}
