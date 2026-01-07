import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../injection_container.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/params/get_all_category.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/get_all_categorys_use_case.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<GetCategoryEvent>(_onGetCategory);
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  Future<void> _onGetCategory(
    GetCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final res = await GetAllCategorysUseCase(
      sl<CategoryRepository>(),
    ).call(event.getCategoryParams!);
    res.fold((failure) => emit(CategoryError(failure.details ?? '')), (
      categorys,
    ) {
      emit(
        GetAllCategoryLoaded(
          getAllCategoryEntity: categorys,
          selectedCategory: 'All',
        ),
      );
    });
  }

  void _onSelectCategory(
    SelectCategoryEvent event,
    Emitter<CategoryState> emit,
  ) {
    if (state is GetAllCategoryLoaded) {
      final currentState = state as GetAllCategoryLoaded;
      emit(currentState.copyWith(selectedCategory: event.selectedCategory));
    }
  }

  // void _onSearchProducts(SearchProductsEvent event, Emitter<ProductState> emit) {
  //   if (state is ProductLoaded) {
  //     if (event.query.isEmpty) {
  //       emit(ProductLoaded(products: _allProductsCache, allProducts: _allProductsCache));
  //     } else {
  //       final filtered = _allProductsCache.where((p) => p.title.toLowerCase().contains(event.query.toLowerCase())).toList();
  //       emit(ProductLoaded(products: filtered, allProducts: _allProductsCache));
  //     }
  //   }
  // }
  //
  // Future<void> _onFilterProductsByCategory(FilterProductsByCategoryEvent event, Emitter<ProductState> emit) async {
  //   emit(ProductLoading());
  //   final result = await getProductsByCategory(GetProductsByCategoryParams(category: event.category));
  //   result.fold(
  //     (failure) => emit(ProductError(_mapFailureToMessage(failure))),
  //     (products) {
  //       // When filtering by category from API, we update the view.
  //       // Note: Client-side search and category API filter might conflict if not handled carefully.
  //       // For simplicity, Category Filter resets the "Base" list.
  //       _allProductsCache = products;
  //       emit(ProductLoaded(products: products, allProducts: products));
  //     },
  //   );
  // }
  //
  // Future<void> _onClearFilter(ClearProductFilterEvent event, Emitter<ProductState> emit) async {
  //     add(GetProductsEvent());
  // }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
