import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestore/features/cart/data/models/response/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/product_bloc.dart';
import '../bloc/bloc_detail/product_detail_bloc.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailBloc>().add(
      GetProductDetailEvent(widget.productId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailError) {
            return Center(child: Text(state.message));
          } else if (state is ProductDetailLoaded) {
            final product = state.product;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'product_${product.id}',
                    child: Container(
                      height: 300.h,
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '\$${product.price}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            Text(
                              ' ${product.rating.rate} (${product.rating.count} reviews)',
                            ),
                            const Spacer(),
                            Chip(label: Text(product.category.toUpperCase())),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          product.description,
                          style: TextStyle(fontSize: 14.sp, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoaded) {
            final product = state.product;
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(
                    AddToCartEvent(
                      CartItemModel(product: product, quantity: 1),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.title} added to cart')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: const Text('Add to Cart'),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
