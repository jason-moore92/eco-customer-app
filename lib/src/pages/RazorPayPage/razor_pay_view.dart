import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trapp/config/config.dart';
import 'package:trapp/src/ApiDataProviders/index.dart';
import 'package:trapp/src/dialogs/index.dart';
import 'package:trapp/src/elements/keicy_progress_dialog.dart';
import 'package:trapp/src/elements/keicy_raised_button.dart';
import 'package:trapp/src/models/index.dart';
import 'package:trapp/src/providers/index.dart';
import 'package:trapp/config/app_config.dart' as config;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';
import 'package:trapp/environment.dart';

class RazorPayView extends StatefulWidget {
  final OrderModel? orderModel;

  RazorPayView({
    Key? key,
    this.orderModel,
  }) : super(key: key);

  @override
  _RazorPayViewState createState() => _RazorPayViewState();
}

class _RazorPayViewState extends State<RazorPayView> {
  /// Responsive design variables
  double deviceWidth = 0;
  double deviceHeight = 0;
  double statusbarHeight = 0;
  double bottomBarHeight = 0;
  double appbarHeight = 0;
  double widthDp = 0;
  double heightDp = 0;
  double fontSp = 0;
  ///////////////////////////////

  KeicyProgressDialog? _keicyProgressDialog;

  Razorpay? _razorpay;

  bool _isSuccess = false;
  String? updatedStatus;

  @override
  void initState() {
    super.initState();

    /// Responsive design variables
    deviceWidth = 1.sw;
    deviceHeight = 1.sh;
    statusbarHeight = ScreenUtil().statusBarHeight;
    bottomBarHeight = ScreenUtil().bottomBarHeight;
    appbarHeight = AppBar().preferredSize.height;
    widthDp = ScreenUtil().setWidth(1);
    heightDp = ScreenUtil().setWidth(1);
    fontSp = ScreenUtil().setSp(1) / ScreenUtil().textScaleFactor;
    ///////////////////////////////

    _keicyProgressDialog = KeicyProgressDialog.of(context);

    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay!.clear();
    super.dispose();
  }

  void _openCheckout() async {
    await _keicyProgressDialog!.show();
    var result = await RazorPayApiProvider.createOrder(amount: (double.parse(widget.orderModel!.paymentDetail!.toPay.toString()) * 100).toInt());
    await _keicyProgressDialog!.hide();
    if (result["success"]) {
      Map<String, dynamic> options = {
        'key': Environment.razorPayKey,
        'amount': (double.parse(widget.orderModel!.paymentDetail!.toPay.toString()) * 100).toInt(),
        'currency': 'INR',
        'name': 'TradeMantri',
        'description': 'Payment for the order ${widget.orderModel!.orderId}',
        'order_id': result["data"]["id"],
        'prefill': {
          'name': "${AuthProvider.of(context).authState.userModel!.firstName} " + "${AuthProvider.of(context).authState.userModel!.lastName}",
        },
        'notes': {},
        // 'notify': {
        //   "sms": AuthProvider.of(context).authState.userModel!.phoneVerified,
        //   "email": AuthProvider.of(context).authState.userModel!.verified,
        // }
        // 'external': {
        //   'wallets': ['paytm']
        // }
      };

      if (AuthProvider.of(context).authState.userModel!.verified!) {
        options["prefill"]["email"] = AuthProvider.of(context).authState.userModel!.email;
      }
      if (AuthProvider.of(context).authState.userModel!.phoneVerified!) {
        options["prefill"]["contact"] = AuthProvider.of(context).authState.userModel!.mobile;
      }
      print(options);

      try {
        _razorpay!.open(options);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // var key = utf8.encode(Environment.razorPayKeySecret);
    // var bytes = utf8.encode("${response.orderId}|${response.paymentId}");

    // Hmac hmacSha256 = Hmac(sha256, key);
    // Digest digest = hmacSha256.convert(bytes);
    // if (digest.toString() == response.signature) {
    _orderPaidCallback(response);
    // } else {
    //   ErrorDialog.show(
    //     context,
    //     widthDp: widthDp,
    //     heightDp: heightDp,
    //     fontSp: fontSp,
    //     isTryButton: false,
    //     text: "Signature failed",
    //     callBack: null,
    //   );
    // }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ErrorDialog.show(
      context,
      widthDp: widthDp,
      heightDp: heightDp,
      fontSp: fontSp,
      isTryButton: false,
      text: "Something was wrong",
      callBack: null,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    SuccessDialog.show(
      context,
      heightDp: heightDp,
      fontSp: fontSp,
      text: "SUCCESS: " + response.walletName!,
    );
  }

  void _orderPaidCallback(PaymentSuccessResponse response) async {
    await _keicyProgressDialog!.show();

    OrderModel orderModel = OrderModel.copy(widget.orderModel!);
    orderModel.paymentApiData = {
      "orderId": response.orderId,
      "paymentId": response.paymentId,
    };

    var result = await OrderApiProvider.updateOrderData(
      orderData: orderModel.toJson(),
      status: AppConfig.orderStatusData[3]["id"],
      changedStatus: true,
      signature: response.signature,
    );
    await _keicyProgressDialog!.hide();

    if (result["success"]) {
      setState(() {
        updatedStatus = AppConfig.orderStatusData[3]["id"];
        _isSuccess = true;
      });
      PaymentSuccessDialog.show(
        context,
        heightDp: heightDp,
        fontSp: fontSp,
        paymentId: response.paymentId,
        orderId: widget.orderModel!.orderId,
        toPay: widget.orderModel!.paymentDetail!.toPay!.toString(),
      );
    } else {
      ErrorDialog.show(
        context,
        widthDp: widthDp,
        heightDp: heightDp,
        fontSp: fontSp,
        isTryButton: false,
        text: "Something was wrong",
        callBack: null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: heightDp * 20),
          onPressed: () {
            Navigator.of(context).pop(updatedStatus);
          },
        ),
        title: Text("Razor Pay Detail", style: TextStyle(fontSize: fontSp * 18, color: Colors.black)),
        elevation: 0,
      ),
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widthDp * 20, vertical: heightDp * 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order ID: ",
                      style: TextStyle(fontSize: fontSp * 16, color: Colors.black),
                    ),
                    Text(
                      "${widget.orderModel!.orderId}",
                      style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: heightDp * 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Merchant/Company name :",
                      style: TextStyle(fontSize: fontSp * 16, color: Colors.black),
                    ),
                    Text(
                      "TradeMantri",
                      style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: heightDp * 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Customer Name:",
                      style: TextStyle(fontSize: fontSp * 16, color: Colors.black),
                    ),
                    Text(
                      "${AuthProvider.of(context).authState.userModel!.firstName} "
                      "${AuthProvider.of(context).authState.userModel!.lastName}",
                      style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                AuthProvider.of(context).authState.userModel!.verified!
                    ? Column(
                        children: [
                          SizedBox(height: heightDp * 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Customer Email :",
                                style: TextStyle(fontSize: fontSp * 16, color: Colors.black),
                              ),
                              Text(
                                "${AuthProvider.of(context).authState.userModel!.email} ",
                                style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      )
                    : SizedBox(),
                AuthProvider.of(context).authState.userModel!.phoneVerified!
                    ? Column(
                        children: [
                          SizedBox(height: heightDp * 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Customer PhoneNumber :",
                                style: TextStyle(fontSize: fontSp * 16, color: Colors.black),
                              ),
                              Text(
                                "${AuthProvider.of(context).authState.userModel!.mobile} ",
                                style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      )
                    : SizedBox(),
                SizedBox(height: heightDp * 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "To Pay",
                      style: TextStyle(fontSize: fontSp * 16, color: Colors.black),
                    ),
                    Text(
                      "₹ ${widget.orderModel!.paymentDetail!.toPay}",
                      style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
          if (_isSuccess)
            SizedBox()
          else
            Padding(
              padding: EdgeInsets.all(heightDp * 20),
              child: Center(
                child: KeicyRaisedButton(
                  width: widthDp * 150,
                  height: heightDp * 35,
                  color: config.Colors().mainColor(1),
                  borderRadius: heightDp * 6,
                  child: Text("Pay", style: TextStyle(fontSize: fontSp * 14, color: Colors.white)),
                  onPressed: _openCheckout,
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
