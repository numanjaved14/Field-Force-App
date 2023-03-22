import 'package:dio/dio.dart';
import 'package:field_force_app/base/base_http_client.dart';
import 'package:field_force_app/constants/shared_pref_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base/models/auth_model.dart';

abstract class DioClient extends BaseHttpClient {
  final Dio _dio = Dio();
  final _baseUrl = "https://biocareapi.azurewebsites.net/api/";
  final _version = "v1";

  // Timeouts
  final connectTimeout = 20 * 1000; // 15 Seconds
  final receiveTimeout = 20 * 1000; // 15 Seconds

  DioClient() {
    _dio.options.baseUrl = "$_baseUrl$_version/";
    _dio.options.connectTimeout = connectTimeout;
    _dio.options.receiveTimeout = receiveTimeout;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError error, handler) async {
          // Do something with response error
          if (error.type == DioErrorType.receiveTimeout) {
            // Call onResponseTimeout
            onResponseTimeout();
          } else if (error.type == DioErrorType.connectTimeout) {
            onRequestTimeout();
          } else if (error.response?.statusCode == 401) {
            SharedPreferences _sharedPref =
                await SharedPreferences.getInstance();
            if (_sharedPref.containsKey(SharedPrefStrings().accessToken)) {
              if (await refreshToken()) {
                return handler.resolve(await _retry(error.requestOptions));
              }
            }
          } else {
            onError(error);
          }
          //return handler.next(error); // continue
        },
        onRequest: (options, handler) async {
          print("Request: ${options.path}");
          SharedPreferences _sharedPref = await SharedPreferences.getInstance();
          if (_sharedPref.containsKey(SharedPrefStrings().accessToken)) {
            String? accessToken =
                _sharedPref.getString(SharedPrefStrings().accessToken);
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          // For example: log the outgoing request
          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          print("Response: ${response.data}");
          // Do something with Response data.
          // For example, log the incoming response
          return handler.next(response);
        },
      ),
    );
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.post<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? refreshToken =
        _sharedPref.getString(SharedPrefStrings().refreshToken);
    String? empID = _sharedPref.getString(SharedPrefStrings().empID);
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);

    final response = await post('Auth/RefreshAccessToken', data: {
      'employeeId': empID,
      'accessToken': accessToken,
      'refreshToken': refreshToken
    });
    AuthModel res = AuthModel.fromJson(response.data);

    if (response.statusCode == 201) {
      _sharedPref.setString(
          SharedPrefStrings().firstName, res.result![0].user!.firstName!);
      _sharedPref.setString(
          SharedPrefStrings().designation, res.result![0].user!.designation!);
      _sharedPref.setString(
          SharedPrefStrings().accessToken, res.result![0].accessToken!);
      _sharedPref.setString(
          SharedPrefStrings().empID, res.result![0].user!.id.toString());
      _sharedPref.setString(SharedPrefStrings().refreshToken,
          res.result![0].refreshToken!.tokenString.toString());
      return true;
    } else {
      // refresh token is wrong
      return false;
    }
  }

  post<T>(String? endPoint, {T? data}) {
    String fullPath = "${_dio.options.baseUrl}${endPoint ?? ""}";
    return _dio.post(
      fullPath,
      data: data ?? {},
    );
  }

  get(String? endPoint, {Map<String, dynamic>? params}) {
    String fullPath = "${_dio.options.baseUrl}${endPoint ?? ""}";
    return _dio.get(
      fullPath,
      queryParameters: params ?? {},
    );
  }
}
