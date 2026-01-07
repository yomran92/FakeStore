
import '../../../error/exceptions.dart';
import 'base_response.dart';

class ErrorEntity extends BaseEntity {
  ErrorEntity({
    this.code,
    this.errorMessage,
    this.details,
    this.validationErrors,
    this.errorException,
  });

  ErrorEntity.fromJson(Map<String, dynamic> parsedJson)
      : super.fromJson(parsedJson) {
    // code = parsedJson['code'];
    // message = parsedJson['message'];
    // details = parsedJson['details'];
    if (parsedJson['error_description'] != null) {
      final error = parsedJson['error_description'];
      if (error is List && error.isNotEmpty)
        for (int i = 0; i < error.length; i++) {
          validationErrors?.add(error[i]);
        }
    }
  }

  ErrorEntity.fromException(AppException exception) {
    errorMessage = exception.message;
    errorException = exception;
  }

  int? code;
  String? errorMessage;
  String? details;
  List<String>? validationErrors = [];
  AppException? errorException;

  @override
  void fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
