import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/dio/factory.dart';
import 'features/products/data/datasources/product_remote_data_source.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/usecases/get_all_products_use_case.dart';
import 'features/products/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(DioFactory.create);
  sl.registerLazySingleton(ProductBloc.new);
  sl.registerLazySingleton(() => GetAllProductUseCase(sl()));

  sl.registerLazySingleton(() => ProductRepository(sl()));
  sl.registerLazySingleton(() =>ProductRemoteDataSource(client:sl()));

}
