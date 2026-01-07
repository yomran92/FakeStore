import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fakestore/features/products/data/repositories/product_repository_impl.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/response/get_all_product_model.dart';
import '../../../domain/usecases/get_product_detail_use_case.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<GetProductDetailEvent>(_onGetProductDetail);
  }

  Future<void> _onGetProductDetail(
    GetProductDetailEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());
    final res = await GetProductDetailUseCase(
      sl<ProductRepository>(),
    ).call(event.productId);

    res.fold(
      (failure) => emit(ProductDetailError(failure.details ?? '')),
      (product) => emit(ProductDetailLoaded(product)),
    );
  }
}
