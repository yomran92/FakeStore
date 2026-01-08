import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../models/params/get_all_category.dart';
import '../models/response/get_all_category_model.dart';

abstract class ICategoryRemoteDataSource  {
   Future<GetAllCategoryModel> getAllCategorys(GetAllCategoryParams model);

}

class CategoryRemoteDataSource extends ICategoryRemoteDataSource {

  CategoryRemoteDataSource( {required this.client});
  final Dio client;

  @override
  Future<GetAllCategoryModel> getAllCategorys(GetAllCategoryParams params) async {

    try {
      final response = await client.get(
        params.url,
      );

         return
          GetAllCategoryModel(
              listMessageContent: (response.data as List)
                  .map((json) => CategoryModel(id: 1, title: json))
                  .toList()
          );

    }on DioException catch (e) {
      throw AppException('Failed to fetch products: ${e.message}');
    } on SocketException {
      throw AppException('No internet connection');
    }
  }



   }
