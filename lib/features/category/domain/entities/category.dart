
import '../../../../core/feature/domain/entities/entity.dart';
import '../../data/models/response/get_all_category_model.dart';


class GetAllCategoryEntity extends Entity {
  GetAllCategoryEntity({

      this.categoryList,
  });

  late List<CategoryModel>? categoryList;

  @override
  List<Object?> get props => [categoryList];
}
