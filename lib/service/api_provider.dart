import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ms_register/model/error_model.dart';

enum ApiStatus { ideal, loading, success, failed }

class ApiProvider extends ChangeNotifier {
  ApiStatus? status = ApiStatus.ideal;
  late Dio _dio;
  static ApiProvider instance = ApiProvider();
  ApiProvider() {
    _dio = Dio();
  }

  Future<Map<String, dynamic>> getRequest(String endpoint) async {
    status = ApiStatus.loading;
    notifyListeners();
    debugPrint('API : $endpoint');
    try {
      Response response = await _dio.get(
        endpoint,
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      debugPrint('Response : ${response.data}');
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return response.data;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      notifyListeners();

      ErrorModel errorModel = ErrorModel(message: resBody['message']);
      return errorModel.toMap();
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      ErrorModel errorModel = ErrorModel(message: 'Unable to process request');
      return errorModel.toMap();
    }
    status = ApiStatus.failed;
    notifyListeners();
    ErrorModel errorModel = ErrorModel(message: 'Unable to process request');
    return errorModel.toMap();
  }

  Future<Map<String, dynamic>> postRequest(
      String endpoint, Map<String, dynamic> requestBody) async {
    status = ApiStatus.loading;
    notifyListeners();
    debugPrint('API : $endpoint');
    debugPrint('Request : ${json.encode(requestBody)}');
    try {
      Response response = await _dio.post(
        endpoint,
        data: json.encode(requestBody),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      debugPrint('Response : ${response.data}');
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return response.data;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      notifyListeners();
      debugPrint(e.toString());
      ErrorModel errorModel = ErrorModel(message: '${resBody['message']}');
      return errorModel.toMap();
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      debugPrint(e.toString());
      ErrorModel errorModel = ErrorModel(message: '${e.toString()}');
      return errorModel.toMap();
    }
    status = ApiStatus.failed;
    notifyListeners();
    ErrorModel errorModel = ErrorModel(message: 'Unable to process request');
    return errorModel.toMap();
  }

  Future<Map<String, dynamic>> putRequest(
      String endpoint, Map<String, dynamic> requestBody) async {
    status = ApiStatus.loading;
    notifyListeners();
    debugPrint('API : $endpoint');
    debugPrint('Request : ${json.encode(requestBody)}');
    try {
      Response response = await _dio.put(
        endpoint,
        data: json.encode(requestBody),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      debugPrint('Response : ${response.data}');
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return response.data;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      notifyListeners();
      ErrorModel errorModel = ErrorModel(message: resBody['message']);
      return errorModel.toMap();
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      ErrorModel errorModel = ErrorModel(message: e.toString());
      return errorModel.toMap();
    }
    status = ApiStatus.failed;
    notifyListeners();
    ErrorModel errorModel = ErrorModel(message: 'Unable to process request');
    return errorModel.toMap();
  }

  Future<Map<String, dynamic>> deleteRequest(String endpoint) async {
    status = ApiStatus.loading;
    notifyListeners();
    debugPrint('API : $endpoint');
    try {
      Response response = await _dio.delete(
        endpoint,
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      debugPrint('Response : ${response.data}');

      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return response.data;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      notifyListeners();
      ErrorModel errorModel = ErrorModel(message: resBody['message']);
      return errorModel.toMap();
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      ErrorModel errorModel = ErrorModel(message: e.toString());
      return errorModel.toMap();
    }
    status = ApiStatus.failed;
    notifyListeners();
    ErrorModel errorModel = ErrorModel(message: 'Unable to process request');
    return errorModel.toMap();
  }
}
