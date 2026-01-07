import 'package:fakestore/features/products/data/models/params/get_all_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widget/app_error_widget.dart';
import '../../../../injection_container.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/pages/cart_screen.dart';
import '../bloc/product_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../widgets/category_filter.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  int _currentLimit = 10;

  @override
  void initState() {
    super.initState();
    _fetchProducts(isRefresh: true);
    // _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _fetchProducts({bool isRefresh = false, bool isLoadMore = false}) {
    if (isRefresh) {
      _currentLimit = 10;
    } else if (isLoadMore) {
      _currentLimit += 10;
    }

    // Get current category from ProductBloc state
    String? currentCategory;
    final productState = context.read<ProductBloc>().state;
    if (productState is GetAllProductLoaded) {
      currentCategory = productState.selectedCategory;
    }

    // FakeStore max is 20, so cap it if needed, but for infinite scroll simulation we just increase
    // If limit > 20, API returns 20 items. logic still holds.

    context.read<ProductBloc>().add(
      GetProductsEvent(
        category: currentCategory,
        getProductsParams: GetAllProductParams(
          body: GetAllProductParamsBody(
            pageNumber: 1,
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
        title: const Text('FakeStore'),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int count = 0;
              if (state is CartLoaded) {
                count = state.items.length;
              }
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                  ),
                  if (count > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$count',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
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
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();
          }
        },
        child: Column(
          children: [
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
                      enablePullUp: true,
                      header: const WaterDropHeader(),
                      footer: CustomFooter(
                        builder: (context, mode) {
                          Widget body;
                          if (mode == LoadStatus.idle) {
                            body = const Text("pull up load");
                          } else if (mode == LoadStatus.loading) {
                            body = const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (mode == LoadStatus.failed) {
                            body = const Text("Load Failed!Click retry!");
                          } else if (mode == LoadStatus.canLoading) {
                            body = const Text("release to load more");
                          } else {
                            body = const Text("No more Data");
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
