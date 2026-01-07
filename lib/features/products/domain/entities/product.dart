import 'package:equatable/equatable.dart';

import '../../../../core/feature/domain/entities/entity.dart';


class Product extends Equatable {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;

  const Product({
      this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating,
  });

  @override
  List<Object?> get props => [id, title, price, description, category, image, rating];
}

class Rating   {
  final double rate;
  final int count;

  const Rating({
    required this.rate,
    required this.count,
  });


}

class GetAllProductEntity extends Entity {
  GetAllProductEntity({

      this.productList,
  });

  late List<Product>? productList;

  @override
  List<Object?> get props => [productList];
}
