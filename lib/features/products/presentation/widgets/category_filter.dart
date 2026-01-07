// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../categories/presentation/bloc/category_bloc.dart';
// import '../bloc/product_bloc.dart';
//
// class CategoryFilter extends StatelessWidget {
//   const CategoryFilter({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CategoryBloc, CategoryState>(
//       builder: (context, state) {
//         if (state is CategoryLoading) {
//           return SizedBox(
//             height: 50.h,
//             child: const Center(child: CircularProgressIndicator()),
//           );
//         } else if (state is CategoryLoaded) {
//           return SizedBox(
//             height: 50.h,
//             child: ListView.separated(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               scrollDirection: Axis.horizontal,
//               itemCount: state.categories.length + 1,
//               separatorBuilder: (_, __) => SizedBox(width: 10.w),
//               itemBuilder: (context, index) {
//                 final isAll = index == 0;
//                 final category = isAll ? 'All' : state.categories[index - 1];
//                 final isSelected = isAll
//                     ? state.selectedCategory.isEmpty
//                     : state.selectedCategory == category;
//
//                 return ChoiceChip(
//                   label: Text(category.toUpperCase()),
//                   selected: isSelected,
//                   onSelected: (selected) {
//                     if (selected) {
//                       context.read<CategoryBloc>().add(
//                         SelectCategoryEvent(isAll ? '' : category),
//                       );
//                       if (isAll) {
//                         context.read<ProductBloc>().add(GetProductsEvent());
//                       } else {
//                         context.read<ProductBloc>().add(
//                           FilterProductsByCategoryEvent(category),
//                         );
//                       }
//                        // Also plain filters should clear text search or keep it?
//                        // Requirements don't specify deep interaction.
//                        // Simple: Category filter overrides list.
//                     }
//                   },
//                 );
//               },
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
