import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trapp/src/helpers/http_plus.dart';
import 'package:trapp/config/config.dart';
import 'package:trapp/environment.dart';

class CategoryApiProvider {
  static int testCount = 0;

  static getCategoryList({
    @required Map<String, dynamic>? location,
    @required int? distance,
    String searchKey = "",
  }) async {
    String apiUrl = 'category/getCategories';
    try {
      String url = Environment.apiBaseUrl! + apiUrl + "?lat=${location!["lat"]}" + "&lng=${location["lng"]}";
      url += "&type=${AppConfig.storeType}";
      url += "&distance=$distance";
      url += "&searchKey=$searchKey";

      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return json.decode(response.body);
    } on SocketException catch (e) {
      return {
        "success": false,
        "message": "Something went wrong",
        // "message": e.osError!.errorCode == 110 || e.osError!.errorCode == 101 ? "Something went wrong" : e.osError!.message,
        "errorCode": e.osError!.errorCode,
      };
    } on PlatformException {
      return {
        "success": false,
        "message": "Something went wrong",
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
      };
    }
  }

  static getCategoryAll() async {
    String apiUrl = 'category/getAll';
    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      return json.decode(response.body);
    } on SocketException catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        // "message": e.osError!.errorCode == 110 || e.osError!.errorCode == 101 ? "Something went wrong" : e.osError!.message,
        "errorCode": e.osError!.errorCode,
      };
    } on PlatformException {
      return {
        "success": false,
        "message": "Something went wrong",
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
      };
    }
  }
}
