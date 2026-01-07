
import '../../../domain/entities/category.dart';
import 'cart_item_model.dart';

class GetCartItemsModel {
  final List<CartItemModel> items;

  const GetCartItemsModel({
    required this.items,
  });

  factory GetCartItemsModel.fromJson(Map<String, dynamic> json) {
    return GetCartItemsModel(
      items: (json['items'] as List)
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
  @override
  GetCartItemsEntity toEntity() => GetCartItemsEntity(

    items:  items?? [],
  );
}

