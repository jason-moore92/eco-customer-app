import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trapp/src/helpers/http_plus.dart';
import 'package:trapp/environment.dart';

class PaymentLinkApiProvider {
  static Future<Map<String, dynamic>> getPaymentData({@required String? id, @required String? paymentLinkId, @required String? status}) async {
    String apiUrl = 'payment_link/get';
    apiUrl += "?id=" + id!;
    apiUrl += "&status=" + status!;
    apiUrl += "&paymentLinkId=" + paymentLinkId!;

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

  static getPaymentLinks({@required String? userId, String searchKey = "", int page = 1}) async {
    String apiUrl = 'payment_link/getPaymentLinks/';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "userId": userId,
          "searchKey": searchKey,
          "limit": 5,
          "page": page,
        }),
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
}
