import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:c9p/app/config/globals.dart' as globals;

import '../../config/app_translation.dart';
import '../../utils/connection_utils.dart';
import 'api_result.dart';

class BaseProvider extends GetConnect {
  void initProvider() {
    httpClient.baseUrl = dotenv.env['BASE_API'];
    httpClient.timeout = Duration(seconds: globals.timeOut);
  }

  // ignore: non_constant_identifier_names
  Future<ApiResult> GET(String url,
      {Map<String, dynamic>? queryParam,
      bool isNewFormat = false,
      String baseUrl = ''}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr);
    }
    if (baseUrl.isNotEmpty) {
      httpClient.baseUrl = baseUrl;
    } else {
      httpClient.baseUrl = dotenv.env['BASE_API'];
    }
    print('============================================================');
    print('[GET] ' + httpClient.baseUrl! + url);
    print("Bearer " + globals.accessToken);
    try {
      final response = await get(url,
          headers: {
            'Authorization': 'Bearer ${globals.accessToken}',
            'Content-Type': 'application/json'
          },
          query: queryParam);
      if (response.isOk && response.body != null) {
        var result = response.body;
        Logger().d(result);
        return ApiResult<dynamic>(
          data: result,
        );
      } else {
        Logger().e('Error ${response.status.code} - ${response.statusText}');
        var result = response.body;
        return ApiResult<dynamic>(
          error: response.statusText ?? '',
          data: result,
        );
      }
    } on Exception catch (exception) {
      Logger().e('[EXCEPTION] ' + exception.toString());
      print('============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr);
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      print('============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr);
    }
  }

  Future<ApiResult> PATCH(String url, dynamic body) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr);
    }
    httpClient.baseUrl = dotenv.env['BASE_API'];
    print('============================================================');
    print('[PATCH] ' + httpClient.baseUrl! + url);
    print('[PARAMS] ' + body.toString());
    print("Bearer " + globals.accessToken);

    try {
      final response = await patch(
        url,
        body,
        headers: {
          'Authorization': 'Bearer ${globals.accessToken}',
          'Content-Type': 'application/json'
        },
      );
      if (response.isOk && response.body != null) {
        var result = response.body;
        Logger().d(result);
        return ApiResult<dynamic>(
            data: result, statusCode: response.statusCode, message: '');
      } else {
        Logger().e('Error ${response.status.code} - ${response.statusText}');
        var result = response.body;
        return ApiResult<dynamic>(
          error: response.statusText ?? '',
          data: result,
        );
      }
    } on Exception catch (exception) {
      Logger().e('[EXCEPTION] ' + exception.toString());
      print('============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr);
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      print('============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr);
    }
  }

  // ignore: non_constant_identifier_names
  Future<ApiResult> POST(
    String url,
    dynamic body, {
    bool isFormData = false,
    String baseUrl = '',
  }) async {
    if (baseUrl.isNotEmpty) {
      httpClient.baseUrl = baseUrl;
    } else {
      httpClient.baseUrl = dotenv.env['BASE_API'];
    }
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr);
    }
    print('============================================================');
    print('[POST] ' + httpClient.baseUrl! + url);
    print("Bearer " + globals.accessToken);
    print('[PARAMS] ' + json.encode(body));
    try {
      var headers = {
        'Authorization': 'Bearer ${globals.accessToken}',
        // 'Content-Type': 'application/json'
      };
      if (!isFormData) headers['Content-Type'] = 'application/json';
      final response = await post(
          url, isFormData ? FormData(body) : json.encode(body),
          headers: headers);
      Logger().d("Status: ${response.statusCode}");
      Logger().d("${response.body}");
      if (response.isOk && response.body != null) {
        var result = response.body;
        return ApiResult<dynamic>(
            data: result, statusCode: response.statusCode, message: '');
      } else {
        Logger().e(
            'Error ${response.status.code} - ${response.statusText} - ${response.bodyString}');
        var result = response.body;
        return ApiResult<dynamic>(
          error: response.statusText ?? '',
          data: result,
        );
      }
    } on Exception catch (exception) {
      Logger().e('[EXCEPTION] ' + exception.toString());
      print('============================================================');
      return ApiResult<dynamic>(
        error: LocaleKeys.network_error.tr,
      );
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      print('============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr);
    }
  }

  // ignore: non_constant_identifier_names
  Future<ApiResult> PUT(String url, dynamic body,
      {String baseUrl = '', bool isNewFormat = false}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr);
    }
    if (baseUrl.isNotEmpty) {
      httpClient.baseUrl = baseUrl;
    } else {
      httpClient.baseUrl = dotenv.env['BASE_API'];
    }
    print('============================================================');
    print('[PUT] ' + httpClient.baseUrl! + url);
    print('[PARAMS] ' + body.toString());
    try {
      final response = await put(
        url,
        body,
        headers: {
          'Authorization': 'Bearer ${globals.accessToken}',
          'Content-Type': 'application/json'
        },
      );
      if (response.isOk && response.body != null) {
        var result = response.body;
        Logger().d(result);
        return ApiResult<dynamic>(
            data: result, statusCode: response.statusCode, message: '');
      } else {
        Logger().e('Error ${response.status.code} - ${response.statusText}');
        var result = response.body;
        return ApiResult<dynamic>(
          error: response.statusText,
          data: result,
        );
      }
    } on Exception catch (exception) {
      Logger().e('[EXCEPTION] ' + exception.toString());
      print('============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr);
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      print('============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr);
    }
  }

  // ignore: non_constant_identifier_names
  Future<ApiResult> DELETE(String url, {String baseUrl = ''}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr);
    }
    if (baseUrl.isNotEmpty) {
      httpClient.baseUrl = baseUrl;
    } else {
      httpClient.baseUrl = dotenv.env['BASE_API'];
    }
    print('============================================================');
    print('[DELETE] ' + httpClient.baseUrl! + url);
    try {
      final response = await delete(
        url,
        headers: {
          'Authorization': 'Bearer ${globals.accessToken}',
          'Content-Type': 'application/json'
        },
      );
      if (response.isOk && response.body != null) {
        var result = response.body;
        Logger().d(result);
        return ApiResult<dynamic>(
            data: result, statusCode: response.statusCode, message: '');
      } else {
        Logger().e('Error ${response.status.code} - ${response.statusText}');
        var result = response.body;
        return ApiResult<dynamic>(
          error: response.statusText ?? '',
          data: result,
        );
      }
    } on Exception catch (exception) {
      Logger().e('[EXCEPTION] ' + exception.toString());
      print('============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr);
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      print('============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr);
    }
  }

  Future<ApiResult> POST_FROM_DATA(String url, dynamic body,
      {bool isMultipart = false,
      bool isContentType = false,
      String baseUrl = '',
      bool isNewFormat = false}) async {
    if (baseUrl.isNotEmpty) {
      httpClient.baseUrl = baseUrl;
    } else {
      httpClient.baseUrl = dotenv.env['BASE_API'];
    }
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr);
    }
    print('============================================================');
    print('[POST] ' + httpClient.baseUrl! + url);
    print("Bearer " + globals.accessToken);
    print('[PARAMS] ' + (!isMultipart ? json.encode(body) : ''));
    try {
      var headers = {
        'Authorization': 'Bearer ${globals.accessToken}',
        'Host': 'auth.com',
      };
      // final request = await httpClient.request(url, body: body);
      final response = await post(url, isMultipart ? body : json.encode(body),
          headers: headers);
      Logger().d(response.body);
      if (response.isOk && response.body != null) {
        var result = response.body;
        return ApiResult<dynamic>(
            data: result,
            statusCode: response.statusCode,
            message: isNewFormat
                ? ''
                : result['meta']['message'] ?? result['meta']['db_message']);
      } else {
        Logger().e(
            'Error ${response.status.code} - ${response.statusText} - ${response.bodyString}');
        var result = response.body;
        return ApiResult<dynamic>(
          error: result["meta"]["message"] ?? response.statusText ?? '',
          data: result,
        );
      }
    } on Exception catch (exception) {
      Logger().e('[EXCEPTION] ' + exception.toString());
      print('============================================================');
      return ApiResult<dynamic>(
        error: LocaleKeys.network_error.tr,
      );
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      print('============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr);
    }
  }
}
