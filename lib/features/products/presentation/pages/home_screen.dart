import 'package:fakestore/features/products/data/models/params/get_all_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/configurations/app_configuration.dart';
import '../../../../core/configurations/app_string.dart';
import '../../../../core/widget/app_error_widget.dart';
import 'package:badges/badges.dart' as badges;
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/pages/cart_screen.dart';
import '../../../category/presentation/page/category_screen.dart';
import '../bloc/product_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../category/presentation/page/widget/category_filter.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController(  initialRefresh: false,
  );
  final TextEditingController _searchController = TextEditingController();

  int _currentLimit = AppConfigurations.PageSize;

  @override
  void initState() {
    super.initState();
    _fetchProducts(isRefresh: true);
    _fetchSearchState( );
   }
_fetchSearchState(){
  if(context.read<ProductBloc>().state is GetAllProductLoaded){
    GetAllProductLoaded sta=context.read<ProductBloc>().state as GetAllProductLoaded;

    _searchController.text=sta.searchQuery;}
 }
  @override
  void dispose() {
    _refreshController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _fetchProducts({bool isRefresh = false, bool isLoadMore = false}) {
    if (isRefresh) {
      _currentLimit = AppConfigurations.PageSize;
    } else if (isLoadMore) {
      _currentLimit += AppConfigurations.PageSize;
    }

     String? currentCategory;
    final productState = context.read<ProductBloc>().state;
    if (productState is GetAllProductLoaded) {
      currentCategory = productState.selectedCategory;
    }

    context.read<ProductBloc>().add(
      GetProductsEvent(
        category: currentCategory,
        getProductsParams: GetAllProductParams(
          body: GetAllProductParamsBody(
             limit: _currentLimit,
            category:
                currentCategory == 'All' || currentCategory == null
                    ? null
                    : currentCategory,
          ),
        ),
        isLoadMore: isLoadMore,
        isRefresh: isRefresh,
      ),
    );
  }

  void _onRefresh() {
    _fetchProducts(isRefresh: true);
  }

  void _onLoading() {
    _fetchProducts(isLoadMore: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Text(AppStrings.appName),
        actions: [

          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CategoryScreen()),
              );
            },
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int count = 0;
              if (state is CartLoaded) {
                count = state.items.length;
              }
              return


                badges.Badge(
                    position: badges.BadgePosition.topEnd(top: 0, end: 3),
                    badgeAnimation: badges.BadgeAnimation.slide(

                    ),
                    showBadge: count>0,
                    badgeStyle: badges.BadgeStyle(
                     ),
                    badgeContent: Text(
                      count.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CartScreen()),
                        );
                      },
                    ),);

            },
          ),
        ],
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductError) {
            _refreshController.refreshFailed();
            _refreshController.loadFailed();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('❌ ${state.message}'),
                duration: const Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is GetAllProductLoaded) {
            _fetchSearchState( );

            _refreshController.refreshCompleted();
            _refreshController.loadComplete();
          }
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: AppStrings.searchProduct,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                onChanged: (value) {
                  String? currentCategory;
                  final state = context.read<ProductBloc>().state;
                  if (state is GetAllProductLoaded) {
                    currentCategory = state.selectedCategory;
                  }
                  context.read<ProductBloc>().add(
                      GetProductsEvent(
                        category: currentCategory,
                        searchQuery: value,
                        getProductsParams: GetAllProductParams(
                          body: GetAllProductParamsBody(
                            limit: _currentLimit,
                            category:
                            currentCategory == null || currentCategory == 'All'
                                ? null
                                : currentCategory,
                          ),
                        ),
                        isRefresh: false,
                        isLoadMore: false,
                      )
                  );

                },
              ),
            ),

            const CategoryFilter(),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetAllProductLoaded) {

                    return SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      enablePullUp: (state.getAllProductEntity.productList?.length??0)
                          <AppConfigurations.ListLimit,
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
                            body = const Text(AppStrings.loadFailedClickRetry  );
                          } else if (mode == LoadStatus.canLoading) {
                            body = const Text(AppStrings.releaseToLoadMore );
                          } else {
                            body = const Text(AppStrings.noMoreData  );
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
                          // Responsive Grid: 2 columns for narrow (<600), 3 for medium (<900), 4 for large
                          int crossAxisCount = 2;
                          if (constraints.maxWidth > 900) {
                            crossAxisCount = 4;
                          } else if (constraints.maxWidth > 600) {
                            crossAxisCount = 3;
                          }

                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.all(16.w),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 16.h,
                                ),
                            itemCount:
                                (state.filteredProducts ??
                                        state.getAllProductEntity.productList)
                                    ?.length,
                            itemBuilder: (context, index) {
                              final products =
                                  state.filteredProducts ??
                                  state.getAllProductEntity.productList;
                              return ProductCard(product: products![index]);
                            },
                          );
                        },
                      ),
                    );
                  } else
                  if (state is ProductError) {
                    return AppErrorWidget(isHorizontal: false,
                      message: state.message,
                      onRetry: _onRefresh ,
                    ) ;
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



