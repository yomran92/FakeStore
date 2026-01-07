import 'package:dio/dio.dart';

import '../../../../core/feature/data/data_sources/remote_data_source.dart';
import '../../../../injection_container.dart';
import '../models/params/get_all_category.dart';
import '../models/response/get_all_category_model.dart';

abstract class ICategoryRemoteDataSource extends RemoteDataSource {
   Future<GetAllCategoryModel> getAllCategorys(GetAllCategoryParams model);

}

class CategoryRemoteDataSource extends ICategoryRemoteDataSource {

  CategoryRemoteDataSource( {required this.client});
  final Dio client;

  @override
  Future<GetAllCategoryModel> getAllCategorys(GetAllCategoryParams params) async {
     final response = await client.get(
      'https://fakestoreapi.com/products/categories',
     );

    if (response.statusCode == 200) {
      return
        GetAllCategoryModel(
          listMessageContent: (response.data as List)
              .map((json) => CategoryModel(id: 1,title:json ))
              .toList()
        );

    } else {
      throw Exception();
    }
  }



   }
