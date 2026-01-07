import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../injection_container.dart';

import '../../../configurations/app_configuration.dart';
import '../../../error/exceptions.dart';
import '../models/params/params_model.dart';

abstract class RemoteDataSource {
  final Dio dio = sl<Dio>()
    ..options.connectTimeout = const Duration(seconds: 10)
    ..options.receiveTimeout = const Duration(seconds: 15)
    ..options.sendTimeout = const Duration(seconds: 15);




  Future<Map<String, dynamic>> get(ParamsModel model) async => _request(
        ()  {
      print((model.baseUrl ?? AppConfigurations.BaseUrl) + (model.url ?? ''));

      return
        dio.get(
          (model.baseUrl ?? AppConfigurations.BaseUrl) + (model.url ?? ''),
          options: Options(
            headers:   {

              ...model.additionalHeaders
            },
            responseType: ResponseType.plain,
          ),
          queryParameters: model.urlParams,
        );},
    model,
    'GET',
  );

  Future<Map<String, dynamic>> _request(
    Future<Response> Function() request,
    ParamsModel model,
    String method,
  ) async {
    Map<String, dynamic> responseJson = {};

    try {
      final response = await request();
      responseJson = _returnResponse(response);
    } on DioException catch (e, stackTrace) {


      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw RequestTimeoutException(message: '⏱️ Connection timed out');
      }

      if (e.error is SocketException ||
          e.type == DioExceptionType.unknown ||
          e.message?.toLowerCase().contains('socket') == true ||
          e.message?.toLowerCase().contains('network is unreachable') == true) {
        throw NoInternetException();
      }

      if (e.response != null) {
        _returnResponse(e.response!);
      } else {
        throw FetchDataException(message: 'Unknown Dio error');
      }
    } on SocketException catch (e, stackTrace) {
      // ✅ DNS or raw socket failure (before Dio’s internals)
       throw NoInternetException();
    } on TimeoutException catch (e, stackTrace) {
         throw RequestTimeoutException(message: 'Request timed out');
    } on AppException catch (e, stackTrace) {
        throw const AppException('AppException');
    } catch (e, stackTrace) {
         rethrow;
    }

    return responseJson;
  }

   dynamic _returnResponse(Response response) {
    final responseJson =
        response.toString().isEmpty ? null : json.decode(response.toString());

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseJson;
      case 400:
        if (responseJson['error']['message'] == 'Invalid refresh token.') {
          throw SessionTimedOutException();
        }
        throw InvalidInputException(
            message: responseJson['error']['message'], data: responseJson,);
      case 409:
        throw InvalidInputException(message: responseJson['error']['message']);
      case 401:
      case 403:
        throw UnauthorisedException(data: responseJson);
      case 404:
        throw NotFoundException(data: responseJson);
      case 500:
        throw ServerErrorException(
            data: responseJson, message: responseJson['ErrorMessage'],);
      default:
        throw ServerErrorException(
          data: responseJson, message: responseJson['ErrorMessage'],);

    }
  }
}
