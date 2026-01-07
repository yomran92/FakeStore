
import '../../../../../core/configurations/app_configuration.dart';
import '../../../../../core/feature/data/models/params/params_model.dart';

class GetAllCategoryParams extends ParamsModel<GetAllCategoryParamsBody> {
  @override
  Map<String, String> get additionalHeaders => {};


  @override
  String get url => '/Category=s';

  @override
  Map<String, dynamic> get urlParams {
    final Map<String, dynamic> res = {};

    res.addAll({
       'PageNumber': body!.pageNumber,
       'limit': body!.limit,

     });


    return res;
  }


  GetAllCategoryParams({super.body}) : super(baseUrl: AppConfigurations.BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, body];
}

class GetAllCategoryParamsBody extends BaseBodyModel {
   late int? pageNumber;
  late int? limit;

  late String? industryId;
  late List<String>? filterIDs;
  late int sortBy;



  late bool? withCompanyName;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = {};
    res.addAll({
      // integer
      'PageNumber': pageNumber,
       // integer

    });

    return res;
  }

  factory GetAllCategoryParamsBody.fromJson(Map<String, dynamic> json) =>
      GetAllCategoryParamsBody(
        pageNumber: json['pageNumber'] as int,
        limit: json['limit'] as int,

      );

  GetAllCategoryParamsBody({
    required this.pageNumber,
    required this.limit,

  });
  @override
  List<Object?> get props => [
     pageNumber,
    limit,

  ];

   }
