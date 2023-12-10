import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:insa_demo_abhay/services/api_endpoints.dart';
import 'package:insa_demo_abhay/services/header.dart';

class NetworkUtil {
  static Future<http.Response?> getApi(String endpointName,
      {required Map<String, String> headers, showLoader = false}) async {
    String url = ApiEndPoints.baseUrl + endpointName;

    var response;
    try {
      response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 403) {
      } else {
        return response;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<http.Response?> postApi(String endpointName, body,
      {required Map<String, String> headers}) async {
    String url = ApiEndPoints.baseUrl + endpointName;

    dynamic response;
    try {
      response = await http
          .post(Uri.parse(url), body: body, headers: headers)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 403) {
      } else {
        return response;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<http.Response?> patchApi(
      BuildContext context, String endpointName, Map<dynamic, dynamic> body,
      {isAuthenticationRequired = true,
      showLoader = false,
      required Map<String, String> headers}) async {
    String url = ApiEndPoints.baseUrl + endpointName;

    var response;

    try {
      response = await http
          .patch(Uri.parse(url),
              body: jsonEncode(body), headers: await getHeader())
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 403) {
      } else {
        return response;
      }

      print('Response [$url] --> ${response.body}');
    } catch (e) {
      print(e.toString());
    }
  }
}
