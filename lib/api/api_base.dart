import 'dart:convert';
import 'dart:io';

import 'package:repos_github/api/models/error.dart';

import 'package:http/http.dart' as http;

enum TypeRequest { get, post, patch, put, delete }

class ApiBase {
  static const String _baseUrl = 'https://api.github.com/';

  static const Map<String, String> _headers = {'Content-Type': 'application/json'};

  Future<dynamic> request(TypeRequest typeRequest, String path) async {
    try {
      http.Response response = await requestByType(typeRequest, Uri.parse(_baseUrl + path));

      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Error(code: response.statusCode, message: jsonDecode(response.body)['message']);
      }
    } on SocketDirection {
      throw 'No Internet connection';
    }
  }

  Future<http.Response> requestByType(
    TypeRequest typeRequest,
    Uri url,
    { Map<String, String> headers = _headers, String bodyEncoded }
  ) async {
    switch(typeRequest) {
      case TypeRequest.get:
        return http.get(url, headers: headers);

      case TypeRequest.post:
        return http.post(url, headers: headers, body: bodyEncoded);

      case TypeRequest.patch:
        return http.patch(url, headers: headers, body: bodyEncoded);

      case TypeRequest.put:
        return http.put(url, headers: headers, body: bodyEncoded);

      case TypeRequest.delete:
        return http.delete(url, headers: headers);
      default:
        return throw Exception('Unknown request type $typeRequest');
    }
  }
}