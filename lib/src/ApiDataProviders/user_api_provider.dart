import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as httpold;
import 'package:trapp/src/helpers/http_plus.dart';
import 'package:trapp/src/models/index.dart';
import 'package:trapp/environment.dart';

class UserApiProvider {
  static registerUser(Map<String, dynamic> userData) async {
    String apiUrl = 'user/register';
    try {
      String url = Environment.apiBaseUrl! + apiUrl;
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
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
        "errorCode": 500,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "errorCode": 500,
      };
    }
  }

  static signInWithEmailAndPassword(String email, String password, String token) async {
    String apiUrl = 'user/login';
    try {
      String url = Environment.apiBaseUrl! + apiUrl;
      final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

      bool isPhoneNumber = numericRegex.hasMatch(email);

      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": email,
          "password": password,
          "isPhoneNumber": isPhoneNumber,
          "fcmToken": token,
        }),
      );

      var result = json.decode(response.body);
      result["errorCode"] = response.statusCode;

      return result;
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
        "errorCode": 500,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "errorCode": 500,
      };
    }
  }

  static resendVerifyLink(String email, String password) async {
    String apiUrl = 'user/resend_verify_link';
    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"email": email, "password": password}),
      );
      var result = json.decode(response.body);
      result["errorCode"] = response.statusCode;

      return result;
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
        "errorCode": 500,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "errorCode": 500,
      };
    }
  }

  static updateUser(UserModel userModel, {File? imageFile}) async {
    String apiUrl = 'user/update/';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var request = httpold.MultipartRequest("POST", Uri.parse(url));
      request.fields.addAll({"data": json.encode(userModel.toJson())});

      var cmnHeaders = await commonHeaders();
      request.headers.addAll(cmnHeaders);

      if (imageFile != null) {
        Uint8List imageByteData = await imageFile.readAsBytes();
        request.files.add(
          httpold.MultipartFile.fromBytes(
            'image',
            imageByteData,
            filename: imageFile.path.split('/').last,
          ),
        );
      }

      var response = await request.send();
      // if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      return json.decode(result);
      // } else {
      //   return {
      //     "success": false,
      //     "message": "Something went wrong",
      //     "errorCode": response.statusCode,
      //   };
      // }
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
        "errorCode": 500,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "errorCode": 500,
      };
    }
  }

  static forgotPassword({@required String? email}) async {
    String apiUrl = 'user/forgot/';

    try {
      String url = Environment.apiBaseUrl! + apiUrl + email!;

      var response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
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
        "errorCode": 500,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "errorCode": 500,
      };
    }
  }

  static verifyOTP({
    @required int? otp,
    @required String? email,
    @required String? newPassword,
    @required String? newPasswordConfirmation,
  }) async {
    String apiUrl = 'user/verify_otp/';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"otp": otp, "email": email, "newPassword": newPassword, "newPasswordConfirmation": newPasswordConfirmation}),
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
        "errorCode": 500,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "errorCode": 500,
      };
    }
  }

  static initiateMobileVerification({
    @required String? mobile,
  }) async {
    String apiUrl = 'user/initiateMobileVerification/';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"mobile": mobile}),
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
        "errorCode": 500,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "errorCode": 500,
      };
    }
  }

  static verifyMobileVerification({
    @required int? token,
    @required String? mobile,
  }) async {
    String apiUrl = 'user/verifyMobileVerification/';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"token": token, "mobile": mobile}),
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
        "errorCode": 500,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "errorCode": 500,
      };
    }
  }

  static changePassword({
    @required String? email,
    @required String? oldPassword,
    @required String? newPassword,
  }) async {
    String apiUrl = 'user/changePassword/';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "oldPassword": oldPassword,
          "newPassword": newPassword,
          "email": email,
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
        "errorCode": 500,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "errorCode": 500,
      };
    }
  }

  static logout({@required String? fcmToken}) async {
    String apiUrl = 'user/logout';

    try {
      String url = Environment.apiBaseUrl! + apiUrl + "?fcmToken=$fcmToken";

      var response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
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
        "errorCode": 500,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "errorCode": 500,
      };
    }
  }

  static getOtherCreds() async {
    String apiUrl = 'user/otherCreds';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      return {
        "success": true,
        "data": json.decode(response.body),
      };
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
        "errorCode": 500,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "errorCode": 500,
      };
    }
  }

  static updateFreshChatRestoreId({@required String? restoreId}) async {
    String apiUrl = 'freshChat/updateRestoreId/';

    try {
      String url = Environment.apiBaseUrl! + apiUrl;

      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "restoreId": restoreId,
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
        "errorCode": 500,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Something went wrong",
        "errorCode": 500,
      };
    }
  }
}
