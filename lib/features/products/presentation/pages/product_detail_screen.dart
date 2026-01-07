// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../cart/domain/entities/cart_item.dart';
// import '../../../cart/presentation/bloc/cart_bloc.dart';
// import '../../domain/entities/product.dart';
//
// class ProductDetailScreen extends StatelessWidget {
//   final Product product;
//
//   const ProductDetailScreen({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(product.title)),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Hero(
//               tag: 'product_${product.id}',
//               child: Container(
//                 height: 300.h,
//                 width: double.infinity,
//                 padding: EdgeInsets.all(16.w),
//                 decoration: BoxDecoration(color: Colors.white),
//                 child: CachedNetworkImage(
//                   imageUrl: product.image,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(16.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.title,
//                     style: TextStyle(
//                       fontSize: 22.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     '\$${product.price}',
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       color: Colors.green,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 16.h),
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.amber),
//                       Text(' ${product.rating.rate} (${product.rating.count} reviews)'),
//                       Spacer(),
//                       Chip(label: Text(product.category.toUpperCase())),
//                     ],
//                   ),
//                   SizedBox(height: 16.h),
//                   Text(
//                     'Description',
//                     style: TextStyle(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     product.description,
//                     style: TextStyle(fontSize: 14.sp, height: 1.5),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
//         ),
//         child: ElevatedButton(
//           onPressed: () {
//             context.read<CartBloc>().add(
//                   AddToCartEvent(CartItem(product: product, quantity: 1)),
//                 );
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('${product.title} added to cart')),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             padding: EdgeInsets.symmetric(vertical: 16.h),
//           ),
//           child: const Text('Add to Cart'),
//         ),
//       ),
//     );
//   }
// }
