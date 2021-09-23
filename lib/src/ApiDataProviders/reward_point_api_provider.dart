import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trapp/src/helpers/http_plus.dart';
import 'package:trapp/environment.dart';

class RewardPointApiProvider {
  static getRewardPoint({@required String? storeId}) async {
    String apiUrl = 'rewardPoint/getRewardPoint/';

    try {
      String url = Environment.apiBaseUrl! + apiUrl + "$storeId";

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
