part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductsEvent extends ProductEvent {
  const GetProductsEvent({
    this.getProductsParams,
    this.isLoadMore = false,
    this.isRefresh = false,
    this.searchQuery,
    this.category,
    this.clearFilters = false,
  });

  final GetAllProductParams? getProductsParams;
  final bool isLoadMore;
  final bool isRefresh;
  final String? searchQuery;
  final String? category;
  final bool clearFilters;

  @override
  List<Object?> get props => [
    getProductsParams,
    isLoadMore,
    isRefresh,
    searchQuery,
    category,
    clearFilters,
  ];
}
