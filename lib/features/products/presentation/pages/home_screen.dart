import 'package:fakestore/features/products/data/models/params/get_all_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../injection_container.dart';
import '../bloc/product_bloc.dart';
import '../widgets/category_filter.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    sl<ProductBloc>().add(GetProductsEvent(
        getProductsParams:GetAllProductParams(body: GetAllProductParamsBody(pageNumber: 1,
            limit:10))
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FakeStore'),
        actions: [
         ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
              onChanged: (value) {
                // context.read<ProductBloc>().add(SearchProductsEvent(value));
              },
            ),
          ),
          const CategoryFilter(),
          Expanded(

            child:
           BlocConsumer<ProductBloc, ProductState>(
    bloc:  sl<ProductBloc>(),
    listener: (context, state) {
    if (state is ProductLoading) {
    print('loading');
    } else if (state is GetAllProductLoaded) {


     } else if (state is ProductError) {
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

                 if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetAllProductLoaded) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      // Responsive Grid: 2 columns for narrow (<600), 3 for medium (<900), 4 for large
                      int crossAxisCount = 2;
                      if (constraints.maxWidth > 900) {
                        crossAxisCount = 4;
                      } else if (constraints.maxWidth > 600) {
                        crossAxisCount = 3;
                      }

                      return GridView.builder(
                        padding: EdgeInsets.all(16.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                        ),
                        itemCount: state.getAllProductEntity.productList?.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: state.getAllProductEntity.productList![index]!);
                        },
                      );
                    },
                  );
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
