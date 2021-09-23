import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trapp/src/helpers/http_plus.dart';
import 'package:trapp/environment.dart';

class CartApiProvider {
  static addCart({@required Map<String, dynamic>? cartData}) async {
    String apiUrl = 'cart/add/';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(cartData),
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

  static backup({
    @required Map<String, dynamic>? cartData,
    @required String? lastDeviceToken,
    @required String? userId,
    String status = "",
  }) async {
    Map<String, dynamic> data = json.decode(json.encode(cartData));

    String apiUrl = 'cart/backup/';
    String url = Environment.apiBaseUrl! + apiUrl;

    try {
      List<Map<String, dynamic>> cartDataList = [];

      data.forEach((storeId, data) {
        cartDataList.add(data);
        for (var i = 0; i < cartDataList.last["products"].length; i++) {
          cartDataList.last["products"][i]["id"] = cartDataList.last["products"][i]["data"]["_id"];
          cartDataList.last["products"][i].remove("data");
        }
        for (var i = 0; i < cartDataList.last["services"].length; i++) {
          cartDataList.last["services"][i]["id"] = cartDataList.last["services"][i]["data"]["_id"];
          cartDataList.last["services"][i].remove("data");
        }
        cartDataList.last.remove("store");
      });

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "cartDataList": cartDataList,
          "lastDeviceToken": lastDeviceToken,
          // "userId": userId,
          "status": status
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

  static getCartData({String status = ""}) async {
    String apiUrl = 'cart/getCartData' + "?status=$status";

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
