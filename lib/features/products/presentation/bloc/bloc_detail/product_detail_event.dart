part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();
}

class GetProductDetailEvent extends ProductDetailEvent {
  final GetProductByIdParams params;

  const GetProductDetailEvent(this.params);

  @override
  List<Object?> get props => [params];
}
