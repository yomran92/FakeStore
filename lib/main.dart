import 'package:fakestore/core/configurations/app_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/configurations/app_string.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/category/presentation/bloc/category_bloc.dart';
import 'features/products/presentation/bloc/bloc_detail/product_detail_bloc.dart';
import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/presentation/pages/home_screen.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ProductBloc>()),
        BlocProvider(create: (context) => sl<ProductDetailBloc>()),
        BlocProvider(create: (context) => sl<CategoryBloc>()),
        BlocProvider(create: (context) => sl<CartBloc>()..add(LoadCartEvent())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
