// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:trapp/config/config.dart';
// import 'package:http/http.dart' as http;

// class ServiceFavoriteApiProvider {
//   static getServiceFavorite({@required String userId}) async {
//     String apiUrl = 'serviceFavorite/getServiceFavorite/';

//     try {
//       String url = Environment.apiBaseUrl! + apiUrl + userId;

//       var response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );
//       return json.decode(response.body);
//     } on SocketException catch (e) {
//       return {
//         "success": false,
//         "message": "Something went wrong",
//         // "message": e.osError!.errorCode == 110 || e.osError!.errorCode == 101 ? "Something went wrong" : e.osError!.message,
//         "errorCode": e.osError!.errorCode,
//       };
//     } on PlatformException catch (e) {
//       return {
//         "success": false,
//         "message": "Something went wrong",
//       };
//     } catch (e) {
//       print(e);
//       return {
//         "success": false,
//         "message": "Something went wrong",
//       };
//     }
//   }

//   static getServiceFavoriteData({
//     @required String userId,
//     String searchKey = "",
//     @required int limit,
//     int page = 1,
//   }) async {
//     String apiUrl = 'serviceFavorite/getServiceFavoriteData';

//     try {
//       String url = Environment.apiBaseUrl! + apiUrl;
//       url += "?userId=$userId";
//       url += "&searchKey=$searchKey";
//       url += "&page=$page";
//       url += "&limit=$limit";
//       var response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );
//       return json.decode(response.body);
//     } on SocketException catch (e) {
//       return {
//         "success": false,
//         "message": "Something went wrong",
//         // "message": e.osError!.errorCode == 110 || e.osError!.errorCode == 101 ? "Something went wrong" : e.osError!.message,
//         "errorCode": e.osError!.errorCode,
//       };
//     } on PlatformException catch (e) {
//       return {
//         "success": false,
//         "message": "Something went wrong",
//       };
//     } catch (e) {
//       print(e);
//       return {
//         "success": false,
//         "message": "Something went wrong",
//       };
//     }
//   }

//   static setServiceFavorite({@required String userId, @required String id, @required String storeId, @required bool isFavorite}) async {
//     String apiUrl = 'serviceFavorite/setServiceFavorite/';

//     try {
//       String url = Environment.apiBaseUrl! + apiUrl;

//       var response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({"userId": userId, "id": id, "storeId": storeId, "isFavorite": isFavorite}),
//       );
//       return json.decode(response.body);
//     } on SocketException catch (e) {
//       return {
//         "success": false,
//         "message": "Something went wrong",
//         // "message": e.osError!.errorCode == 110 || e.osError!.errorCode == 101 ? "Something went wrong" : e.osError!.message,
//         "errorCode": e.osError!.errorCode,
//       };
//     } on PlatformException catch (e) {
//       return {
//         "success": false,
//         "message": "Something went wrong",
//       };
//     } catch (e) {
//       print(e);
//       return {
//         "success": false,
//         "message": "Something went wrong",
//       };
//     }
//   }
// }
