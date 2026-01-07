
import 'package:equatable/equatable.dart';

class UpdateCartQuantityParams extends Equatable {
  final int productId;
  final int quantity;
  const UpdateCartQuantityParams({required this.productId, required this.quantity});
  @override
  List<Object> get props => [productId, quantity];
}
