
import '../../../../../core/configurations/app_configuration.dart';
import '../../../../../core/feature/data/models/params/params_model.dart';

class GetAllCategoryParams extends ParamsModel<GetAllCategoryParamsBody> {
  @override
  Map<String, String> get additionalHeaders => {};


  @override
  String get url => '${AppConfigurations.BaseUrl}products/categories';

  @override
  Map<String, dynamic> get urlParams {
    final Map<String, dynamic> res = {};




    return res;
  }


  GetAllCategoryParams({super.body}) : super(baseUrl: AppConfigurations.BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, body];
}

class GetAllCategoryParamsBody extends BaseBodyModel {





  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = {};

    return res;
  }

  factory GetAllCategoryParamsBody.fromJson(Map<String, dynamic> json) =>
      GetAllCategoryParamsBody(


      );

  GetAllCategoryParamsBody(


  );
  @override
  List<Object?> get props => [


  ];

   }
