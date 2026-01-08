part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class GetAllCategoryLoaded extends CategoryState {
  final GetAllCategoryEntity getAllCategoryEntity;
  final String selectedCategory;
  final String  searchQuery;
  final List<CategoryModel>?  filteredData;

  const GetAllCategoryLoaded({
    required this.getAllCategoryEntity,
    this.selectedCategory = 'All',
    this.searchQuery='',
    this.filteredData ,

  });

  GetAllCategoryLoaded copyWith({
    GetAllCategoryEntity? getAllCategoryEntity,
    String? selectedCategory,
    String? searchQuery,
    List<CategoryModel>?  filteredData,

  }) {
    return GetAllCategoryLoaded(
      getAllCategoryEntity: getAllCategoryEntity ?? this.getAllCategoryEntity,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      filteredData: filteredData ?? this.filteredData,
    );
  }

  @override
  List<Object> get props => [getAllCategoryEntity, selectedCategory,searchQuery];
}

class CategoryError extends CategoryState {
  final String message;
  const CategoryError(this.message);
  @override
  List<Object> get props => [message];
}
