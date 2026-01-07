part of 'cart_bloc.dart';

// States
abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}
class CartLoading extends CartState {}
class CartSuccess extends CartState {}
class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final double totalAmount;

  const CartLoaded({required this.items, required this.totalAmount});

  @override
  List<Object> get props => [items, totalAmount];
}
class CartError extends CartState {
  final String message;
  const CartError(this.message);
  @override
  List<Object> get props => [message];
}
