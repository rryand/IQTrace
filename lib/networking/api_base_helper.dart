import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    var request = new http.MultipartRequest(
      'PATCH',
      Uri.parse(_url + endpoint),
    );

    request.headers['Content-Type'] = 'multipart/form-data';
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    request.files.add(
      new http.MultipartFile.fromBytes(
        'file',
        await File(imagePath).readAsBytes(),
        contentType: new MediaType('image', 'jpg')
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataHttpError('No internet connection');
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

  Map<String, String> _getAuthHeader(String token) {
    return { 'Authorization': 'Bearer $token' };
  }
}
