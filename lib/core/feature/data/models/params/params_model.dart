import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ParamsModel<BodyModelType extends BaseBodyModel>
    extends Equatable {
  final BodyModelType? body;

  /// set this to override base url
  final String? baseUrl;

  /// add additional headers to request here
  Map<String, String> get additionalHeaders;



  /// [url] to api endpoint (without base url)
  /// not url is without page number or length
  /// you should fill base_url property in base provider
  String? get url;

  /// query parameters to be included in url
  Map<String, dynamic> get urlParams;

  bool get authorized => false;

  const ParamsModel({this.body, this.baseUrl});

  bool get hasFile {
    final jsonBody = body?.toJson();
    for (final v in jsonBody?.entries.toList() ?? []) {
      if (v.contains('file')) {
        return true;
      }
    }
    return false;
  }
}

abstract class BaseBodyModel {
  Map<String, dynamic> toJson();
}
