import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fakestore/features/products/data/repositories/product_repository_impl.dart';
import '../../../../injection_container.dart';
import '../../data/models/params/get_all_product.dart';
import '../../data/models/response/get_all_product_model.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_all_products_use_case.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetProductsEvent>(_onGetProducts);
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    // Handle clear filters
    if (event.clearFilters && state is GetAllProductLoaded) {
      final currentState = state as GetAllProductLoaded;
      emit(
        currentState.copyWith(
          searchQuery: '',
          selectedCategory: 'All',
          filteredProducts: currentState.getAllProductEntity.productList,
        ),
      );
      return;
    }

    // Handle category filter - fetch from API
    if (event.category != null) {
      // Show loading indicator only if not refreshing/loading more
      if (!event.isLoadMore && !event.isRefresh) {
        emit(ProductLoading());
      } else if (state is GetAllProductLoaded) {
        emit(
          (state as GetAllProductLoaded).copyWith(
            isLoadingMore: event.isLoadMore,
          ),
        );
      }

      // Fetch products by category from API
      final res = await GetAllProductUseCase(
        sl<ProductRepository>(),
      ).call(event.getProductsParams!);

      res.fold((failure) => emit(ProductError(failure.details ?? '')), (
        products,
      ) {
        emit(
          GetAllProductLoaded(
            getAllProductEntity: products,
            filteredProducts: products.productList,
            selectedCategory: event.category,
          ),
        );
      });
      return;
    }

    // Handle initial fetch, refresh or load more
    if (!event.isLoadMore && !event.isRefresh) {
      emit(ProductLoading());
    } else if (state is GetAllProductLoaded) {
      emit(
        (state as GetAllProductLoaded).copyWith(
          isLoadingMore: event.isLoadMore,
        ),
      );
    }

    // Fetch products from API
    final res = await GetAllProductUseCase(
      sl<ProductRepository>(),
    ).call(event.getProductsParams!);

    res.fold((failure) => emit(ProductError(failure.details ?? '')), (
      products,
    ) {
      emit(
        GetAllProductLoaded(
          getAllProductEntity: products,
          filteredProducts: products.productList,
          selectedCategory: 'All',
        ),
      );
    });
  }
}
