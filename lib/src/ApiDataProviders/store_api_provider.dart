import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trapp/config/config.dart';
import 'package:trapp/src/helpers/http_plus.dart';
import 'package:trapp/environment.dart';

class StoreApiProvider {
  static getStoreList({
    String? categoryId,
    @required Map<String, dynamic>? location,
    @required int? distance,
    int page = 1,
    bool isPaginated = true,
    String searchKey = "",
  }) async {
    String apiUrl = 'store/getStores';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;
      url += "?lat=${location!["lat"]}" + "&lng=${location["lng"]}";
      url += "&type=${AppConfig.storeType}";
      url += "&distance=$distance";
      url += "&categoryId=$categoryId";
      url += "&page=$page";
      url += "&searchKey=$searchKey";
      url += "&limit=${AppConfig.countLimitForList}";
      url += "&isPaginated=$isPaginated";

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

  static getStoreData({@required String? id}) async {
    String apiUrl = 'store/get/' + id!;

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

  static getFCMTokenByStoreUserId({@required String? storeId}) async {
    String apiUrl = 'store/getStoreTokens/' + storeId!;

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
