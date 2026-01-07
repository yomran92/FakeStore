import '../../../../../core/configurations/app_configuration.dart';
import '../../../../../core/feature/data/models/params/params_model.dart';

class GetProductByIdParams extends ParamsModel<GetProductByIdParamsBody> {
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  String get url  =>
      '${AppConfigurations.BaseUrl}products/${body!.id}';


  @override
  Map<String, dynamic> get urlParams {
    final Map<String, dynamic> res = {};



    return res;
  }

  GetProductByIdParams({super.body}) : super(baseUrl: AppConfigurations.BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, body];
}

class GetProductByIdParamsBody extends BaseBodyModel {
  late int  id;


  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = {};
       return res;
  }



  GetProductByIdParamsBody({required this.id,});

  List<Object?> get props => [id, ];
}
