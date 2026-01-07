import '../../../../../core/feature/data/models/responses/response_model.dart';
 import '../../../domain/entities/category.dart';
 class GetAllCategoryModel extends ResponseModel {
  List<CategoryModel>? listMessageContent;

  GetAllCategoryModel({
    this.listMessageContent,
  });

  GetAllCategoryModel.fromJson(Map<String, dynamic>  json) {
    try {

      listMessageContent =
          (json['data'] as List<dynamic>?)
              ?.map((e) => CategoryModel.fromJson(e))
              .toList() ??
              [];
    } catch (e, st) {

      rethrow;
    }
  }

  @override
  Map<String, dynamic> toJson() => {

  };

  @override
  GetAllCategoryModel fromJson(Map<String, dynamic> json) =>
      GetAllCategoryModel.fromJson(json);

  @override
  GetAllCategoryEntity toEntity() => GetAllCategoryEntity(

    categoryList: listMessageContent ?? [],
  );
}
class CategoryModel {
  final int id;
  final String title;

  const CategoryModel({
    required this.id,
    required this.title,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}

