
import '../../../../../core/configurations/app_configuration.dart';
import '../../../../../core/feature/data/models/params/params_model.dart';

class GetAllProductParams extends ParamsModel<GetAllProductParamsBody> {
  @override
  Map<String, String> get additionalHeaders => {};


  @override
  String get url => '/product=s';

  @override
  Map<String, dynamic> get urlParams {
    final Map<String, dynamic> res = {};

    res.addAll({
       'PageNumber': body!.pageNumber,
       'limit': body!.limit,

     });


    return res;
  }


  GetAllProductParams({super.body}) : super(baseUrl: AppConfigurations.BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, body];
}

class GetAllProductParamsBody extends BaseBodyModel {
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

  factory GetAllProductParamsBody.fromJson(Map<String, dynamic> json) =>
      GetAllProductParamsBody(
        pageNumber: json['pageNumber'] as int,
        limit: json['limit'] as int,

      );

  GetAllProductParamsBody({
    required this.pageNumber,
    required this.limit,

  });
  @override
  List<Object?> get props => [
     pageNumber,
    limit,

  ];

   }
