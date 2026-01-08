import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../core/configurations/app_configuration.dart';
import '../../../../core/configurations/app_string.dart';
import '../../../../core/widget/app_error_widget.dart';
import '../../../products/data/models/params/get_all_product.dart';
import '../../../products/presentation/bloc/product_bloc.dart';
import '../../data/models/params/get_all_category.dart';
import '../../data/models/response/get_all_category_model.dart';
import '../bloc/category_bloc.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final TextEditingController _searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController(  initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    initSearch();  }

  @override
  void dispose() {
  _refreshController.dispose();
  _searchController.dispose();    super.dispose();
  }
void initSearch(){
  if(context.read<CategoryBloc>().state is GetAllCategoryLoaded){
    GetAllCategoryLoaded sta=context.read<CategoryBloc>().state as GetAllCategoryLoaded;

    _searchController.text=sta.searchQuery;}
}
  void _fetchCategory({bool isRefresh = false, bool isLoadMore = false}) {


    context.read<CategoryBloc>().add(
      GetCategoryEvent(
        getCategoryParams: GetAllCategoryParams(
          body: GetAllCategoryParamsBody(),
        ),
      ),
    );
  }

  void _onRefresh() {
    _fetchCategory(isRefresh: true);
  }

  void _onLoading() {
    _fetchCategory(isLoadMore: true);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(
        title:   Text(AppStrings.category),
        actions: [


         ],
      ),
      body: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryLoading) {
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
              return AppErrorWidget(isHorizontal: false,
                message: categoryState.message,
                onRetry: (){
                  _searchController.text='';
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
              return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: AppStrings.searchCategory,
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16
                              .w),
                        ),
                        onChanged: (value) {
                          context.read<CategoryBloc>().add(
                              GetCategoryEvent(
                                 searchQuery: value,
                                getCategoryParams: GetAllCategoryParams(
                                  body: GetAllCategoryParamsBody(

                                  ),
                                ),

                              )
                          );

                        },
                      ),
                    ),

                    Expanded(
                        child: SmartRefresher(
                          controller: _refreshController,
                          enablePullDown: false,
                          enablePullUp:   false,
                          header: const WaterDropHeader(),
                          footer: CustomFooter(
                            builder: (context, mode) {
                              Widget body;
                              if (mode == LoadStatus.idle) {
                                body = const Text(AppStrings.pullUpLoad);
                              } else if (mode == LoadStatus.loading) {
                                body = const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (mode == LoadStatus.failed) {
                                body =
                                const Text(AppStrings.loadFailedClickRetry);
                              } else if (mode == LoadStatus.canLoading) {
                                body = const Text(AppStrings.releaseToLoadMore);
                              } else {
                                body = const Text(AppStrings.noMoreData);
                              }
                              return SizedBox(
                                height: 55.0.h,
                                child: Center(child: body),
                              );
                            },
                          ),
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return SizedBox(
                                child: ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w),
                                  scrollDirection: Axis.vertical,
                                  itemCount:



                                  ((
                                      categoryState.filteredData ??
                                      categoryState.getAllCategoryEntity
                                      .categoryList)?.length ??
                                      0) +
                                      1,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(width: 10.w),
                                  itemBuilder: (context, index) {
                                    final isAll = index == 0;
                                    final CategoryModel category =
                                    isAll
                                        ? CategoryModel(id: 0, title: 'All')
                                        :

                                    (categoryState.filteredData??
                                    categoryState
                                        .getAllCategoryEntity
                                        .categoryList)![index - 1];

                                    final isSelected =
                                        categoryState.selectedCategory ==
                                            category.title;

                                    return ChoiceChip(
                                      selectedColor: Colors.deepPurple,
                                      label: Text(category.title.toUpperCase()),
                                      selected: isSelected,
                                      onSelected: (selected) {
                                        if (selected) {
                                          context.read<CategoryBloc>().add(
                                            SelectCategoryEvent(
                                                selectedCategory: category
                                                    .title),
                                          );

                                          context.read<ProductBloc>().add(
                                            GetProductsEvent(
                                              category: category.title,
                                              getProductsParams: GetAllProductParams(
                                                body: GetAllProductParamsBody(
                                                  limit: AppConfigurations
                                                      .PageSize,
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
                            },
                          ),
                        )
                    )
                  ]
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

