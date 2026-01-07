import 'package:dio/dio.dart';
import 'package:fakestore/features/products/data/models/params/get_all_product.dart';
import 'package:fakestore/features/products/data/models/response/get_all_product_model.dart';

import '../../../../core/feature/data/data_sources/remote_data_source.dart';
import '../../../../injection_container.dart';

abstract class IProductRemoteDataSource extends RemoteDataSource {
   Future<GetAllProductModel> getAllProducts(GetAllProductParams model);

}

class ProductRemoteDataSource extends IProductRemoteDataSource {

  ProductRemoteDataSource( {required this.client});
  final Dio client;

  @override
  Future<GetAllProductModel> getAllProducts(GetAllProductParams params) async {
     final response = await client.get(
      'https://fakestoreapi.com/products',
      // queryParameters: limit != null ? {'limit': limit} : null,
    );

    if (response.statusCode == 200) {
      return
        GetAllProductModel(
          listMessageContent: (response.data as List)
              .map((json) => ProductModel.fromJson(json))
              .toList()
        );

    } else {
      throw Exception();
    }
  }

  // @override
  // Future<ProductModel> getProductDetails(int id) async {
  //   final response = await client.get('https://fakestoreapi.com/products/$id');
  //
  //   if (response.statusCode == 200) {
  //     return ProductModel.fromJson(response.data);
  //   } else {
  //     throw ServerException();
  //   }
  // }

   }
