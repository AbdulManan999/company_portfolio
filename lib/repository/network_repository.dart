import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/network/environment_config.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/constants.dart';
import '../utils/exceptions.dart';

final clientProvider = StateProvider((ref) async {
  Map<String, dynamic> headers;
  String baseUrl;
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  if (EnvironmentConfig.IS_LIVE) {
    headers = {
      "BUILD-VERSION": version,
      "BUILD_VERSION_CODE": 1,
      "DEVICE_TYPE": Platform.isAndroid ? "android" : "ios",
      "OS-VERSION": "14",
      "HEADER-API-KEY": EnvironmentConfig.API_KEY_LIVE,
      "HEADER-APP-KEY": EnvironmentConfig.APP_KEY_LIVE,
    };

    baseUrl = EnvironmentConfig.BASE_API_URL_LIVE;
  } else {
    headers = {
      "BUILD-VERSION": version,
      "BUILD_VERSION_CODE": 1,
      "DEVICE_TYPE": Platform.isAndroid ? "android" : "ios",
      "OS-VERSION": "14",
      "HEADER-API-KEY": EnvironmentConfig.API_KEY_LIVE,
      "HEADER-APP-KEY": EnvironmentConfig.APP_KEY_LIVE,
    };
    baseUrl = EnvironmentConfig.BASE_API_URL_DEV;
  }
  Dio dio = Dio(BaseOptions(
    headers: headers,
    baseUrl: baseUrl,
    connectTimeout: Constants.connectionTimeOut,
    receiveTimeout: Constants.receiveTimeOut,
  ));
  dio.interceptors.add(DioLoggingInterceptor(level: Level.body, compact: false));
  return dio;
});

final networkRepositoryProvider = StateProvider((ref) => _NetworkRepository(ref));

class _NetworkRepository {
  Ref ref;

  _NetworkRepository(this.ref);

  Future<dynamic> getRequest(String url, UrlSuffix requestType, bool isAuthorization, {Map<String, dynamic>? data, bool? isMultipart, FormData? formData}) async {
    try {
      Dio dio = await ref.read(clientProvider);
      late Response response;
      switch (requestType) {
        case UrlSuffix.GET:
          // if (isAuthorization) {
          //   LoginResponse? userData = await read(authRepository).getUserData();
          //   if(userData?.token != null){
          //     response = await dio.get(url,
          //         // options: Options(headers: {"authorization": "Bearer ${userData?.token}"})
          //     );
          //   }else{
          //     throw DataException(message: "Auth Token not found");
          //   }
          // }else{
          //   response = await dio.get(url);
          // }
          if (isAuthorization) {
            String? token = await Utils.getAccessToken();
            if (isMultipart ?? false) {
              response = await dio.get(url, options: Options(headers: {"authorization": "Bearer ${token!}"}));
            } else {
              response = await dio.get(url, options: Options(headers: {"authorization": "Bearer ${token!}"}));
            }
          } else {
            response = await dio.get(url);
          }
          // response = await dio.get(url);
          break;
        case UrlSuffix.POST:
          // if (isAuthorization) {
          //   LoginResponse? userData = await read(authRepository).getUserData();
          //   if(userData?.token != null){
          //     response = await dio.post(url, data: data,
          //         // options: Options(headers: {"authorization": "Bearer ${userData?.token}"})
          //     );
          //   }else{
          //     throw DataException(message: "Auth Token not found");
          //   }
          // }else{
          //   response = await dio.post(url, data: data);
          // }
          if (isAuthorization) {
            String? token = await Utils.getAccessToken();
            if (isMultipart ?? false) {
              response = await dio.post(url, data: formData, options: Options(headers: {"authorization": "Bearer ${token!}"}));
            } else {
              response = await dio.post(url, data: data, options: Options(headers: {"authorization": "Bearer ${token!}"}));
            }
          } else {
            if (isMultipart ?? false) {
              response = await dio.post(url, data: formData);
            } else {
              response = await dio.post(url, data: data);
            }
          }
          break;
        case UrlSuffix.PUT:
          break;
        case UrlSuffix.DELETE:
          break;
      }
      if (response.data.toString().contains("<!DOCTYPE html>") || response.data.toString().contains("<div")) {
        await FirebaseCrashlytics.instance.recordFlutterError(FlutterErrorDetails(exception: response.data.toString()));
        throw DataException(message: Constants.errorInternalServer);
      }

      return response;
    } on DioError catch (error) {
      await FirebaseCrashlytics.instance.recordFlutterError(FlutterErrorDetails(exception: error.toString()));
      throw DataException.fromDioError(error);
    }
  }
}

enum UrlSuffix { GET, POST, PUT, DELETE }
