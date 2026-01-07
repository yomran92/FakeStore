import 'package:equatable/equatable.dart';

import '../../../../products/data/models/response/get_all_product_model.dart';

class CartItemModel extends Equatable {
  final ProductModel product;
  final int quantity;

  const CartItemModel({
    required this.product,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final productJson = json['product'];
    if (productJson == null) {
      throw const FormatException('Product is missing in CartItemModel');
    }

    return CartItemModel(
      product: ProductModel.fromJson(productJson as Map<String, dynamic>),
      quantity: json['quantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  CartItemModel copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [product, quantity];
}
