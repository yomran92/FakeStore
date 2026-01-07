import '../../../../../core/configurations/app_configuration.dart';
import '../../../../../core/feature/data/models/params/params_model.dart';

class GetAllProductParams extends ParamsModel<GetAllProductParamsBody> {
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  String get url => '/products';

  @override
  Map<String, dynamic> get urlParams {
    final Map<String, dynamic> res = {};

    if (body?.limit != null) {
      res['limit'] = body!.limit;
    }
    // FakeStore API doesn't use PageNumber for offset-based pagination in the way we usually do,
    // but we'll include it if needed for local logic, though API only respects 'limit' and 'sort'.

    return res;
  }

  GetAllProductParams({super.body}) : super(baseUrl: AppConfigurations.BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, body];
}

class GetAllProductParamsBody extends BaseBodyModel {
  late int? pageNumber;
  late int? limit;
  late String? category;

  late bool? withCompanyName;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = {};
    if (limit != null) res['limit'] = limit;
    if (category != null) res['category'] = category;
    if (pageNumber != null) res['pageNumber'] = pageNumber;
    return res;
  }

  factory GetAllProductParamsBody.fromJson(Map<String, dynamic> json) =>
      GetAllProductParamsBody(
         limit: json['limit'] as int?,
        category: json['category'] as String?,
      );

  GetAllProductParamsBody({this.pageNumber, this.limit, this.category});

  List<Object?> get props => [pageNumber, limit, category];
}
