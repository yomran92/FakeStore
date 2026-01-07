import 'package:dartz/dartz.dart';
import 'package:fakestore/features/category/data/models/params/get_all_category.dart';
import '../../../../core/feature/domain/entities/error_entity.dart';
import '../../../../core/feature/domain/repositories/irepository.dart';
 import '../entities/category.dart';


abstract class ICategoryRepository extends IRepository {
  Future<Either<ErrorEntity, GetAllCategoryEntity>> getAllCategorys(GetAllCategoryParams model);

}
