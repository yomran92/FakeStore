import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestore/core/configurations/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.shoppingCart)),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return const Center(child: Text(AppStrings.yourCartIsEmpty));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(16.w),
                    itemCount: state.items.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return Dismissible(
                        key: Key(item.product.id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20.w),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) {
                          context.read<CartBloc>().add(RemoveFromCartEvent(item.product.id));
                        },
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 60.w,
                                  height: 60.h,
                                  child: CachedNetworkImage(
                                    imageUrl: item.product.image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text('\$${item.product.price}'),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove_circle, color: Colors.grey),
                                      onPressed: () {
                                        if (item.quantity > 1) {
                                           context.read<CartBloc>().add(
                                            UpdateCartQuantityEvent(item.product.id, item.quantity - 1),
                                          );
                                        } else {
                                           context.read<CartBloc>().add(RemoveFromCartEvent(item.product.id));
                                        }
                                      },
                                    ),
                                    Text('${item.quantity}'),
                                    IconButton(
                                      icon: Icon(Icons.add_circle, color: Colors.blue),
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                          UpdateCartQuantityEvent(item.product.id, item.quantity + 1),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${AppStrings.total}: \$${state.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
