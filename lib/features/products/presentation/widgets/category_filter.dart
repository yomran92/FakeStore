import 'package:fakestore/features/category/data/models/params/get_all_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import '../../../../injection_container.dart';
import '../../../category/data/models/response/get_all_category_model.dart';
import '../../../category/presentation/bloc/category_bloc.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
if(sl<CategoryBloc>().state is CategoryInitial){
  sl<CategoryBloc>().add(GetCategoryEvent(getCategoryParams: GetAllCategoryParams(
    body: GetAllCategoryParamsBody(pageNumber: 1, limit: 10)
  )));
}

    return

      BlocConsumer<CategoryBloc, CategoryState>(
          bloc:  sl<CategoryBloc>(),
          listener: (context, state) {
            if (state is CategoryLoading) {
              print('loading');
            } else if (state is GetAllCategoryLoaded) {


            } else if (state is CategoryError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('❌ ${state.message!}'),
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },

       builder: (context, state) {
        if (state is CategoryLoading) {
          return SizedBox(
            height: 50.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is GetAllCategoryLoaded) {
          return SizedBox(
            height: 50.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemCount: (state.getAllCategoryEntity.categoryList?.length??0) + 1,
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                final isAll = index == 0;
                final CategoryModel category = isAll ? CategoryModel(
                    id: 0,
                    title:'All')
                    :
                state.getAllCategoryEntity.categoryList![index - 1];
                final isSelected = isAll
                    ? state.getAllCategoryEntity.categoryList?.isEmpty
                    : state.getAllCategoryEntity.categoryList == category;

                return ChoiceChip(
                  label: Text(category.title.toUpperCase()),
                  selected: isSelected??false,
                  onSelected: (selected) {
                    // if (selected) {
                    //   context.read<CategoryBloc>().add(
                    //     SelectCategoryEvent(isAll ? '' : category),
                    //   );
                    //   // if (isAll) {
                    //   //   context.read<ProductBloc>().add(GetProductsEvent());
                    //   // } else {
                    //   //   context.read<ProductBloc>().add(
                    //   //     FilterProductsByCategoryEvent(category),
                    //   //   );
                    //   // }
                    //    // Also plain filters should clear text search or keep it?
                    //    // Requirements don't specify deep interaction.
                    //    // Simple: Category filter overrides list.
                    // }
                  },
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
