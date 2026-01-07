import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fakestore/features/products/data/repositories/product_repository_impl.dart';
import '../../../../injection_container.dart';
import '../../data/models/params/get_all_product.dart';
import '../../domain/entities/product.dart';
 import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_all_products_use_case.dart';
part 'product_event.dart';
part 'product_state.dart';
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {


    on<GetProductsEvent>(_onGetProducts);
    // on<SearchProductsEvent>(_onSearchProducts);
    // on<FilterProductsByCategoryEvent>(_onFilterProductsByCategory);
    // on<ClearProductFilterEvent>(_onClearFilter);
  }

  Future<void> _onGetProducts(GetProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
  final res = await GetAllProductUseCase(sl<ProductRepository>())
        .call(event.getProductsParams!);
    res.fold(
      (failure) => emit(ProductError(failure.details??'')),
      (products) {
         emit(GetAllProductLoaded(getAllProductEntity:  products));
      },
    );
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
