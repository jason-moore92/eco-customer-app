import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trapp/src/helpers/http_plus.dart';
import 'package:trapp/environment.dart';

class StoreJobPostingsApiProvider {
  static getStoreJobPostingsData({
    String storeId = "",
    @required String? userId,
    @required String? status,
    double? latitude,
    double? longitude,
    int? distance,
    String searchKey = "",
    @required int? limit,
    int page = 1,
  }) async {
    String apiUrl = 'store_job_posings/getAll/';
    apiUrl += "?storeId=$storeId";
    apiUrl += "&userId=$userId";
    apiUrl += "&status=$status";
    apiUrl += "&latitude=$latitude";
    apiUrl += "&longitude=$longitude";
    apiUrl += "&distance=$distance";
    apiUrl += "&searchKey=$searchKey";
    apiUrl += "&page=$page";
    apiUrl += "&limit=$limit";

    try {
      String url = Environment.apiBaseUrl! + apiUrl;
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
        "message": e.osError!.errorCode == 110 || e.osError!.errorCode == 101 ? "Something went wrong" : e.osError!.message,
        "errorCode": e.osError!.errorCode,
      };
    } on PlatformException catch (e) {
      return {
        "success": false,
        "message": e.message,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "get /$apiUrl error",
      };
    }
  }

  static getStoreJob({@required String? jobId, @required String? storeId}) async {
    String apiUrl = 'store_job_posings/get?jobId=$jobId&storeId=$storeId';
    try {
      String url = Environment.apiBaseUrl! + apiUrl;

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
    } on PlatformException catch (e) {
      print(e);
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
