import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fakestore/features/cart/data/models/response/cart_item_model.dart';
import '../../../../core/feature/domain/use_cases/use_case.dart';
import '../../../../injection_container.dart';
import '../../data/models/params/cart_item_param.dart';
import '../../data/models/params/remove_from_cart_param.dart';
import '../../data/models/params/update_cart_param.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../domain/usecases/get_add_to_cart_use_case.dart';
import '../../domain/usecases/get_all_cart_use_case.dart';
import '../../domain/usecases/get_remove_from_cart_use_case.dart';
import '../../domain/usecases/update_cart_use_case.dart';
part 'cart_event.dart';
part 'cart_state.dart';

 class CartBloc extends Bloc<CartEvent, CartState> {


  CartBloc( ) : super(CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartQuantityEvent>(_onUpdateQuantity);
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
     final res = await GetCart(sl<CartRepository>())
        .call();
    res.fold(
          (failure) => emit(CartError(_mapFailureToMessage(failure))),
          (items) => emit(CartLoaded(items: items.items??[], totalAmount: _calculateTotal( items.items??[]))),
    );
  }

  Future<void> _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    // emit(CartLoading());

    final CartItemParams cartItemParams=
    CartItemParams(product:event.item.product
        ,quantity: 1);
    final res = await AddToCart(sl<CartRepository>())
        .call(cartItemParams
     );
    res.fold(
          (failure) => emit(CartError(_mapFailureToMessage(failure))),
          (items) => emit(CartSuccess( )
          ));
    // await addToCart(event.item);
    // add(LoadCartEvent());
  }

  Future<void> _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    // await removeFromCart(RemoveFromCartParams(productId: event.productId));
    // add(LoadCartEvent());
    final RemoveFromCartParams removeFromCartParams=
    RemoveFromCartParams(productId:event.productId
       );
    final res = await RemoveFromCart(sl<CartRepository>())
        .call(removeFromCartParams
    );
    res.fold(
            (failure) => emit(CartError(_mapFailureToMessage(failure))),
            (items) => emit(CartSuccess( )
        ));
  }

  Future<void> _onUpdateQuantity(UpdateCartQuantityEvent event, Emitter<CartState> emit) async {
    // await updateCartQuantity(UpdateCartQuantityParams(productId: event.productId, quantity: event.quantity));
    // add(LoadCartEvent());
    final UpdateCartQuantityParams removeFromCartParams=
    UpdateCartQuantityParams(productId:event.productId,quantity: event.quantity
    );
    final res = await UpdateCartQuantity(sl<CartRepository>())
        .call(removeFromCartParams
    );
    res.fold(
            (failure) => emit(CartError(_mapFailureToMessage(failure))),
            (items) => emit(CartSuccess( )
        ));
  }

  double _calculateTotal(List<CartItemModel> items) {
    double total = 0;
    for (var item in items) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  String _mapFailureToMessage(  failure) {
    return 'Cache Error';
  }
}
