import 'package:fakestore/core/configurations/app_configuration.dart';
import 'package:fakestore/features/category/data/models/params/get_all_category.dart';
import 'package:fakestore/features/products/data/models/params/get_all_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widget/app_error_widget.dart';
 import '../../../category/data/models/response/get_all_category_model.dart';
import '../../../category/presentation/bloc/category_bloc.dart';
import '../../../products/presentation/bloc/product_bloc.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<CategoryBloc>().state is CategoryInitial) {
      context.read<CategoryBloc>().add(
        GetCategoryEvent(
          getCategoryParams: GetAllCategoryParams(
            body: GetAllCategoryParamsBody(),
          ),
        ),
      );
    }

    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryLoading) {
          // Optional: handle global loading indicator if needed
        } else if (state is CategoryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ ${state.message}'),
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, categoryState) {
          if (categoryState is CategoryError) {
            return AppErrorWidget(isHorizontal: true,
              message: categoryState.message,
              onRetry: (){
                context.read<CategoryBloc>().add(
                  GetCategoryEvent(
                    getCategoryParams: GetAllCategoryParams(
                      body: GetAllCategoryParamsBody( ),
                    ),
                  ),
                );
              },
            ) ;
          }
          else
          if (categoryState is CategoryLoading) {
            return SizedBox(
              height: 50.h,
              child: const Center(child: CircularProgressIndicator()),
            );
          } else if (categoryState is GetAllCategoryLoaded) {
            return SizedBox(
              height: 50.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                itemCount:
                    (categoryState.getAllCategoryEntity.categoryList?.length ??
                        0) +
                    1,
                separatorBuilder: (_, __) => SizedBox(width: 10.w),
                itemBuilder: (context, index) {
                  final isAll = index == 0;
                  final CategoryModel category =
                      isAll
                          ? CategoryModel(id: 0, title: 'All')
                          : categoryState
                              .getAllCategoryEntity
                              .categoryList![index - 1];

                  final isSelected =
                      categoryState.selectedCategory == category.title;

                  return ChoiceChip(
                    selectedColor: Colors.deepPurple,
                    label: Text(category.title.toUpperCase()),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                         context.read<CategoryBloc>().add(
                          SelectCategoryEvent(selectedCategory: category.title),
                        );

                         context.read<ProductBloc>().add(
                          GetProductsEvent(
                            category: category.title,
                            getProductsParams: GetAllProductParams(
                              body: GetAllProductParamsBody(
                                 limit: AppConfigurations.PageSize,
                                category:
                                    category.title == 'All'
                                        ? null
                                        : category.title,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
