import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trapp/config/config.dart';
import 'package:trapp/src/helpers/http_plus.dart';
import 'package:trapp/environment.dart';

class CouponsApiProvider {
  static getCouponList({
    @required String? storeId,
    @required String? status,
    String? userId,
    List<dynamic>? productCategories,
    List<dynamic>? serviceCategories,
    List<dynamic>? productIds,
    List<dynamic>? serviceIds,
    String searchKey = "",
    @required int? limit,
    int page = 1,
  }) async {
    String apiUrl = 'coupons/getCoupons/';
    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "storeId": storeId,
          "userId": userId,
          "productCategories": productCategories,
          "serviceCategories": serviceCategories,
          "productIds": productIds,
          "serviceIds": serviceIds,
          "status": status,
          "searchKey": searchKey,
          "page": page,
          "limit": limit,
        }),
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

  static getCoupon({@required String? couponId}) async {
    String apiUrl = 'coupons/get?couponId=$couponId';
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

  static getCouponsByStoreCategory({
    @required String? categoryId,
    @required Map<String, dynamic>? location,
    @required int? distance,
    String searchKey = "",
    @required int? limit,
    int page = 1,
    bool listonline = true,
    bool isDeleted = false,
  }) async {
    String apiUrl = 'coupons/getCouponsByStoreCategory';
    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "categoryId": categoryId,
          "lat": location!["lat"],
          "lng": location["lng"],
          "distance": distance,
          "type": AppConfig.storeType,
          "searchKey": searchKey,
          "page": page,
          "limit": limit,
          "listonline": listonline,
          "isDeleted": isDeleted,
        }),
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
