
part of 'product_bloc.dart';
abstract class ProductEvent extends Equatable {
  const ProductEvent();

}

 class GetProductsEvent extends ProductEvent {
  const GetProductsEvent({this.getProductsParams});
  final GetAllProductParams? getProductsParams;
  @override
  List<Object?> get props => [getProductsParams];
 }

class ClearProductFilterEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}
