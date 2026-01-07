import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fakestore/features/products/data/models/params/get_all_product.dart';
import 'package:fakestore/features/products/data/models/response/get_all_product_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/feature/data/data_sources/remote_data_source.dart';

abstract class IProductRemoteDataSource extends RemoteDataSource {
  Future<GetAllProductModel> getAllProducts(GetAllProductParams model);
  Future<ProductModel> getProductDetail(int id);
}

class ProductRemoteDataSource extends IProductRemoteDataSource {
  ProductRemoteDataSource({required this.client});
  final Dio client;

  @override
  Future<GetAllProductModel> getAllProducts(GetAllProductParams params) async {
    try {
      // Build the endpoint based on category
      String endpoint = 'https://fakestoreapi.com/products';
      final category = params.body?.category;

      if (category != null &&
          category.isNotEmpty &&
          category.toLowerCase() != 'all') {
        endpoint = 'https://fakestoreapi.com/products/category/$category';
      }

      final response = await client.get(
        endpoint,
        queryParameters: params.urlParams,
      );

      return GetAllProductModel(
        listMessageContent:
            (response.data as List)
                .map((json) => ProductModel.fromJson(json))
                .toList(),
      );
    } on DioException catch (e) {
      throw AppException('Failed to fetch products: ${e.message}');
    } on SocketException {
      throw AppException('No internet connection');
    }
  }

  @override
  Future<ProductModel> getProductDetail(int id) async {
    try {
      final response = await client.get(
        'https://fakestoreapi.com/products/$id',
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw AppException('Failed to fetch product details');
      }
    } on DioException catch (e) {
      throw AppException('Failed to fetch product details: ${e.message}');
    } on SocketException {
      throw AppException('No internet connection');
    }
  }
}
