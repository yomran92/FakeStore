part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class GetAllProductLoaded extends ProductState {
  final GetAllProductEntity getAllProductEntity;
  final bool isLoadingMore;
  final String? selectedCategory;
  final String  searchQuery;
  final List<ProductModel>? filteredProducts;

  const GetAllProductLoaded({
    required this.getAllProductEntity,
    this.isLoadingMore = false,
    this.selectedCategory,
    this.searchQuery='',
    this.filteredProducts,
  });

  @override
  List<Object> get props => [
    getAllProductEntity,
    isLoadingMore,
    searchQuery,
    selectedCategory ?? '',
    filteredProducts ?? [],
  ];

  GetAllProductLoaded copyWith({
    GetAllProductEntity? getAllProductEntity,
    bool? isLoadingMore,
    String? searchQuery,
    String? selectedCategory,
    List<ProductModel>? filteredProducts,
  }) {
    return GetAllProductLoaded(
      getAllProductEntity: getAllProductEntity ?? this.getAllProductEntity,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object> get props => [message];
}
