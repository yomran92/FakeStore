import '../../../../../core/feature/data/models/responses/response_model.dart';
import '../../../domain/entities/product.dart';
 class GetAllProductModel extends ResponseModel {
  int? pageIndex;
  int? totalPages;
  int? pageSize;
  int? totalRecords;
  bool? hasNextPage;
  bool? hasPreviousPage;
  String? errorMessage;
  bool? hasError;
  List<ProductModel>? listMessageContent;

  GetAllProductModel({
    this.pageIndex,
    this.totalPages,
    this.pageSize,
    this.totalRecords,
    this.hasNextPage,
    this.hasPreviousPage,
    this.errorMessage,
    this.hasError,
    this.listMessageContent,
  });

  GetAllProductModel.fromJson(Map<String, dynamic>  json) {
    try {

      listMessageContent =
          (json['data'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
              [];
    } catch (e, st) {

      rethrow;
    }
  }

  @override
  Map<String, dynamic> toJson() => {
    'PageIndex': pageIndex,
    'TotalPages': totalPages,
    'PageSize': pageSize,
    'TotalRecords': totalRecords,
    'HasNextPage': hasNextPage,
    'HasPreviousPage': hasPreviousPage,
    'ErrorMessage': errorMessage,
    'HasError': hasError,
  };

  @override
  GetAllProductModel fromJson(Map<String, dynamic> json) =>
      GetAllProductModel.fromJson(json);

  @override
  GetAllProductEntity toEntity() => GetAllProductEntity(

    productList: listMessageContent ?? [],
  );
}
class ProductModel extends Product {
  const ProductModel({
    required int id,
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
    required RatingModel rating,
  }) : super(
          id: id,
          title: title,
          price: price,
          description: description,
          category: category,
          image: image,
          rating: rating,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: RatingModel.fromJson(json['rating']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': (rating as RatingModel).toJson(),
    };
  }
}

class RatingModel extends Rating {
  const RatingModel({
    required double rate,
    required int count,
  }) : super(rate: rate, count: count);

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
