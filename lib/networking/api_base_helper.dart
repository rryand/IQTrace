import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:iq_trace/exceptions.dart';

class ApiBaseHelper {
  final _url = dotenv.env['API_URL'] as String;

  Future<dynamic> get(String endpoint, [String? token]) async {
    print('API GET, url $endpoint');
    var responseJson;
    
    try {
      final response = await http.get(
        Uri.parse(_url + endpoint),
        headers: token != null ? _getAuthHeader(token) : null,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataHttpError('No internet connection');
    }

    return responseJson;
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body, [String? token]) async {
    print('API POST, url $endpoint');
    var responseJson;

    final Map<String, String> headers = token != null ? 
      _getAuthHeader(token) : 
      {};
    headers['Content-type'] = 'application/json';
    
    try {
      final response = await http.post(
        Uri.parse(_url + endpoint),
        headers: headers,
        body: jsonEncode(body),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataHttpError('No internet connection');
    }

    return responseJson;
  }

  Future<dynamic> postForm(String endpoint, Map<String, dynamic> body, [String? token]) async {
    print('API POST, url $endpoint');
    var responseJson;

    final Map<String, String> headers = token != null ? 
      _getAuthHeader(token) : 
      {};
    
    try {
      final response = await http.post(
        Uri.parse(_url + endpoint),
        headers: headers,
        body: body,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataHttpError('No internet connection');
    }

    return responseJson;
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body, [String? token]) async {
    print('API PUT, url $endpoint');
    var responseJson;

    final Map<String, String> headers = token != null ? 
      _getAuthHeader(token) : 
      {};
    headers['Content-type'] = 'application/json';

    try {
      final response = await http.put(
        Uri.parse(_url + endpoint),
        headers: headers,
        body: jsonEncode(body),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataHttpError('No internet connection');
    }

    return responseJson;
  }

  Future<dynamic> patch(String endpoint, Map<String, dynamic> body, [String? token]) async {
    print('API PATCH, url $endpoint');
    var responseJson;
    
    try {
      final response = await http.post(
        Uri.parse(_url + endpoint),
        headers: token != null ? _getAuthHeader(token) : null,
        body: body,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataHttpError('No internet connection');
    }

    return responseJson;
  }

  Future<void> multipartPatch(String endpoint, String imagePath, [String? token]) async {
    var responseJson;
    var dio = Dio();
         
    dio.options.baseUrl = _url;

    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imagePath, contentType: new MediaType('image', 'jpg'))
    });

    try {
      final response = await dio.patch(endpoint, data: formData);
      responseJson = _returnDioResponse(response);
    } on SocketException {
      throw FetchDataHttpError('No internet connection');
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.statusCode);
        responseJson = _returnDioResponse(e.response!);
      } else {
        print(e.message);
      }
    }

    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestHttpError(response.body.toString());
      case 401:
        throw UnauthorizedHttpError(response.body.toString());
      case 403:
        throw ForbiddenHttpError(response.body.toString());
      case 500:
      default:
        throw FetchDataHttpError(
          'Error occured while communicating with server\n'
          'status code: ${response.statusCode}\n'
          '${response.body.toString()}');
    }
  }

  dynamic _returnDioResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        print(response.data);
        break;
      case 400:
        throw BadRequestHttpError(response.data.toString());
      case 401:
        throw UnauthorizedHttpError(response.data.toString());
      case 403:
        throw ForbiddenHttpError(response.data.toString());
      case 500:
      default:
        throw FetchDataHttpError(
          'Error occured while communicating with server\n'
          'status code: ${response.statusCode}\n'
          '${response.data.toString()}');
    }
  }

  Map<String, String> _getAuthHeader(String token) {
    return { 'Authorization': 'Bearer $token' };
  }
}
