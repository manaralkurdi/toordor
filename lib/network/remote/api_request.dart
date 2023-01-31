import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../const/constant.dart';

class ApiRequest {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        // followRedirects: false,
        // validateStatus: (status) {
        //   return status! < 500;
        // },
      ),
    );
    debugPrint(dio.runtimeType.toString());
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    String? token, required String url,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //'Content-Language': lang,
      'Authorization': token
    };
    return await dio!.get(
      path,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String path,
    dynamic data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };
    return await dio!.post(
      path,
      data: data,
    );
  }

  static Future<Response> postMultiPartData({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
    Function(int, int)? onSendProgress,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': token ?? '',
    };
    return await dio!.post(
      path,
      queryParameters: query,
      data: data,
      onSendProgress: onSendProgress,
    );
  }

  static Future<Response> postDataWithPhoto({
    required String path,
    Map<String, dynamic>? query,
    required dynamic data,
    String? token,
    Function(int, int)? onSendProgress,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': token,
    };
    return await dio!.post(
      path,
      data: data,
    );
  }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.put(
      path,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> patchData({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.patch(
      path,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.delete(
      path,
      queryParameters: query,
      data: data,
    );
  }
}
