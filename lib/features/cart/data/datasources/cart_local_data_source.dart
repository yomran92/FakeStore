import 'package:fakestore/features/cart/data/models/response/get_cart_items_model.dart';

import '../models/response/cart_item_model.dart';

abstract class ICartLocalDataSource {
  Future<GetCartItemsModel> getCart();
  Future<void> addToCart(CartItemModel item);
  Future<void> removeFromCart(int productId);
  Future<void> updateQuantity(int productId, int quantity);
  Future<void> clearCart();
}

class CartLocalDataSource extends ICartLocalDataSource {
  final List<CartItemModel> _cart = [];

  @override
  Future<GetCartItemsModel> getCart() async {
    return GetCartItemsModel(items: List.from(_cart));
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    final index = _cart.indexWhere(
      (element) => element.product.id == item.product.id,
    );
    if (index != -1) {
      final existing = _cart[index];
      _cart[index] = CartItemModel(
        product: existing.product as dynamic,
        quantity: existing.quantity + item.quantity,
      );
    } else {
      _cart.add(item);
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    _cart.removeWhere((element) => element.product.id == productId);
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    final index = _cart.indexWhere(
      (element) => element.product.id == productId,
    );
    if (index != -1) {
      if (quantity <= 0) {
        _cart.removeAt(index);
      } else {
        final existing = _cart[index];
        _cart[index] = CartItemModel(
          product: existing.product as dynamic,
          quantity: quantity,
        );
      }
    }
  }

  @override
  Future<void> clearCart() async {
    _cart.clear();
  }
}
