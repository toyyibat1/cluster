import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'failure.dart';

class ApiBaseHelper {
  // Url for private endpoints
  static const String _baseUrl = "https://moni-staging-1.vercel.app/api/";

  /// [DIO] setup for private endpoints
  final dio = Dio(
    BaseOptions(
        baseUrl: _baseUrl, contentType: 'application/json;charset=UTF-8'),
  );

  Future<dynamic> get(String url) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    try {
      final response = await dio.get(url);
      var result = response.data;
      return result;
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    } on TimeoutException {
      throw Failure('Connection Timeout: Check your internet connection');
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Failure('Connection Timeout: Check your internet connection');
      } else {
        throw Failure(e.message);
      }
    }
  }
}
