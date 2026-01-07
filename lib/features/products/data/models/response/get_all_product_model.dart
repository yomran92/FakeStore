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

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
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
      'rating': rating.toJson(),
    };
  }
}

class RatingModel {
  final double rate;
  final int count;

  const RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
