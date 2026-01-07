abstract class BaseEntity<T> {
  static const CONTENT_KEY = 'content';

  T? content;
  String? result;
  dynamic errorDescription;
  int? errorCode;

  BaseEntity();
  BaseEntity.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorDescription = json['error_description'];
    errorCode = json['error_code'];
  }

  fromJson(Map<String, dynamic> json);
}
