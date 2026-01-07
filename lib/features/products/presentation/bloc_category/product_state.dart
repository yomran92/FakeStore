part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class GetAllProductLoaded extends ProductState {
  final GetAllProductEntity  getAllProductEntity;

  const GetAllProductLoaded({    required this.getAllProductEntity});
  
  @override
  List<Object> get props => [getAllProductEntity];
}
 class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object> get props => [message];
}
