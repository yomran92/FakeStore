
part of 'cart_bloc.dart';
abstract class CartEvent extends Equatable {
 const CartEvent();
 @override
 List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
 final CartItemModel item;
 const AddToCartEvent(this.item);
 @override
 List<Object> get props => [item];
}

class RemoveFromCartEvent extends CartEvent {
 final int productId;
 const RemoveFromCartEvent(this.productId);
 @override
 List<Object> get props => [productId];
}

class UpdateCartQuantityEvent extends CartEvent {
 final int productId;
 final int quantity;
 const UpdateCartQuantityEvent(this.productId, this.quantity);
 @override
 List<Object> get props => [productId, quantity];
}

