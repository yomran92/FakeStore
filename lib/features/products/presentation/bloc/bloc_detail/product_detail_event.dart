part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();
}

class GetProductDetailEvent extends ProductDetailEvent {
  final int productId;

  const GetProductDetailEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}
