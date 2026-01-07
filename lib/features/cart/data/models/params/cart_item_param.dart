
import 'package:equatable/equatable.dart';
import 'package:fakestore/features/products/data/models/response/get_all_product_model.dart';

class CartItemParams extends Equatable {
  final ProductModel product;
  final int quantity;

  const CartItemParams({
    required this.product,
    required this.quantity,
  });

  CartItemParams copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return CartItemParams(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [product, quantity];
}

