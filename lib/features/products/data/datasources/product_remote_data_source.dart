import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fakestore/features/products/data/models/params/get_all_product.dart';
import 'package:fakestore/features/products/data/models/response/get_all_product_model.dart';

import '../../../../core/error/exceptions.dart';
import '../models/params/get_product_by_id.dart';

abstract class IProductRemoteDataSource  {
  Future<GetAllProductModel> getAllProducts(GetAllProductParams model);
  Future<ProductModel> getProductDetail(GetProductByIdParams model);
}

class ProductRemoteDataSource extends IProductRemoteDataSource {
  ProductRemoteDataSource({required this.client});
  final Dio client;

  @override
  Future<GetAllProductModel> getAllProducts(GetAllProductParams params) async {
    try {

      final response = await client.get(
        params.url,
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
  Future<ProductModel> getProductDetail(GetProductByIdParams model) async {
    try {
      final response = await client.get(
       model.url,
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
