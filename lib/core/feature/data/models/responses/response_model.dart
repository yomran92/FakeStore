
import '../../../domain/entities/entity.dart';

abstract class ResponseModel {
  static const CONTENT_KEY = 'content';
  fromJson(Map<String, dynamic> json);
  Entity toEntity();
}
