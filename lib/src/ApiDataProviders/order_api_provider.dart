import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trapp/src/helpers/http_plus.dart';
import 'package:trapp/environment.dart';
import 'package:trapp/src/models/index.dart';

class OrderApiProvider {
  static addOrder({@required Map<String, dynamic>? orderData, @required String? qrCode}) async {
    String apiUrl = 'order/add/';

    orderData!["qrCodeData"] = qrCode;

    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(orderData),
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

  static getOrderData({
    @required String? userId,
    @required String? status,
    String searchKey = "",
    @required int? limit,
    int page = 1,
  }) async {
    String apiUrl = 'order/getOrderData';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;
      // url += "?userId=$userId";
      url += "?status=$status";
      url += "&searchKey=$searchKey";
      url += "&page=$page";
      url += "&limit=$limit";
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

  static getStoreInvoices({
    String searchKey = "",
    @required int? limit,
    int page = 1,
  }) async {
    String apiUrl = 'order/getStoreInvoices';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;
      url += "?searchKey=$searchKey";
      url += "&page=$page";
      url += "&limit=$limit";
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

  static getScratchCardData({
    String searchKey = "",
    @required int? limit,
    int page = 1,
  }) async {
    String apiUrl = 'order/getScratchCardData';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;
      url += "?1=1";
      url += "&searchKey=$searchKey";
      url += "&page=$page";
      url += "&limit=$limit";
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

  static getOrderDataByCategory({
    @required String? userId,
    @required String? storeCategoryId,
    @required int? limit,
    int page = 1,
  }) async {
    String apiUrl = 'order/getOrderDataByCategory';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;
      // url += "?userId=$userId";
      url += "?storeCategoryId=$storeCategoryId";
      url += "&page=$page";
      url += "&limit=$limit";

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

  static getOrder({
    @required String? orderId,
    @required String? storeId,
    @required String? userId,
  }) async {
    String apiUrl = 'order/getOrder';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;
      url += "?storeId=$storeId";
      url += "&userId=$userId";
      url += "&orderId=$orderId";

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

  // static changeOrderStatus({
  //   @required String orderId,
  //   @required String userId,
  //   @required String status,
  //   @required String storeId,
  // }) async {
  //   String apiUrl = 'order/changeStatus/';

  //   try {
  //     String url = Environment.apiBaseUrl! + apiUrl;

  //     var response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode({
  //         "orderId": orderId,
  //         "userId": userId,
  //         "status": status,
  //         "storeId": storeId,
  //       }),
  //     );
  //     return json.decode(response.body);
  //   } on SocketException catch (e) {
  //     return {
  //       "success": false,
  //       "message": "Something went wrong",
  //       // "message": e.osError!.errorCode == 110 || e.osError!.errorCode == 101 ? "Something went wrong" : e.osError!.message,
  //       "errorCode": e.osError!.errorCode,
  //     };
  //   } on PlatformException catch (e) {
  //     return {
  //       "success": false,
  //       "message": "Something went wrong",
  //     };
  //   } catch (e) {
  //     print(e);
  //     return {
  //       "success": false,
  //       "message": "Something went wrong",
  //     };
  //   }
  // }

  static updateOrderData({
    @required Map<String, dynamic>? orderData,
    @required String? status,
    @required bool? changedStatus,
    @required String? signature,
  }) async {
    String apiUrl = 'order/update/';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"orderData": orderData, "status": status, "changedStatus": changedStatus, "signature": signature}),
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

  static Future<Map<String, dynamic>> getGraphDataByUser({
    @required String? userId,
    @required String? filter,
    String storeCategoryId = "",
  }) async {
    String apiUrl = 'order/getGraphDataByUser';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;
      url += "?userId=$userId";
      url += "&filter=$filter";
      url += "&storeCategoryId=$storeCategoryId";

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

  static getDashboardDataByUser({@required String? userId, String storeCategoryId = ""}) async {
    String apiUrl = 'order/getDashboardDataByUser';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;
      url += "?userId=$userId";
      url += "&storeCategoryId=$storeCategoryId";

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

  static Future<Map<String, dynamic>> getCategoryOrderDataByUser({@required String? userId}) async {
    String apiUrl = 'order/getCategoryOrderDataByUser';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;
      url += "?userId=$userId";

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

  static Future<Map<String, dynamic>> getCouponUsage({
    @required String? storeId,
    @required String? couponId,
  }) async {
    String apiUrl = 'order/getCouponUsage';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;
      url += "?storeId=$storeId";
      url += "&couponId=$couponId";

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
}
