import '../../../../../core/configurations/app_configuration.dart';
import '../../../../../core/feature/data/models/params/params_model.dart';

class GetAllProductParams extends ParamsModel<GetAllProductParamsBody> {
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  String get url  {
    String urlTmp=AppConfigurations.BaseUrl;
    urlTmp=urlTmp+'products';
    if(body!.category!=null){
      urlTmp=urlTmp+'';
    }
    if (body!.category  != null &&
        body!.category!.isNotEmpty &&
        body!.category!.toLowerCase() != 'all') {
      urlTmp = '${urlTmp}/category/${body!.category}';
    }
    return urlTmp;

  }

  @override
  Map<String, dynamic> get urlParams {
    final Map<String, dynamic> res = {};

    if (body?.limit != null) {
      res['limit'] = body!.limit;
    }

    return res;
  }

  GetAllProductParams({super.body}) : super(baseUrl: AppConfigurations.BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, body];
}

class GetAllProductParamsBody extends BaseBodyModel {
   late int? limit;
  late String? category;


  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = {};
    if (limit != null) res['limit'] = limit;
    if (category != null) res['category'] = category;
    return res;
  }

  factory GetAllProductParamsBody.fromJson(Map<String, dynamic> json) =>
      GetAllProductParamsBody(
         limit: json['limit'] as int?,
        category: json['category'] as String?,
      );

  GetAllProductParamsBody({  this.limit, this.category});

  List<Object?> get props => [   limit, category];
}
