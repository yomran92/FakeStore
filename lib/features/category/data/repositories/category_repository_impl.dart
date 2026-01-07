import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_data_source.dart';
import '../models/params/get_all_category.dart';
import '../models/response/get_all_category_model.dart';

 class CategoryRepository extends ICategoryRepository {
  CategoryRemoteDataSource remoteDataSource;

  CategoryRepository(this.remoteDataSource);



  @override
  Future<Either<ErrorEntity, GetAllCategoryEntity>> getAllCategorys(GetAllCategoryParams model) async {
    try {
      final GetAllCategoryModel remote = await remoteDataSource.getAllCategorys(model);
      return Right(remote.toEntity());
    } on AppException catch (e, st) {

      return Left(ErrorEntity.fromException(e));
    }
  }

}
