// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:share/share.dart';
// import 'package:trapp/config/config.dart';
// import 'package:trapp/src/dialogs/index.dart';
// import 'package:trapp/src/elements/keicy_progress_dialog.dart';

// import 'package:trapp/src/elements/keicy_raised_button.dart';
// import 'package:trapp/src/elements/qrcode_widget.dart';

// import 'package:trapp/src/helpers/date_time_convert.dart';
// import 'package:trapp/src/helpers/encrypt.dart';
// import 'package:trapp/src/pages/RazorPayPage/index.dart';

// import 'package:trapp/src/providers/index.dart';
// import 'package:trapp/config/app_config.dart' as config;
// import 'package:trapp/src/elements/keicy_checkbox.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'index.dart';

// class OrderDetailView extends StatefulWidget {
//   final Map<String, dynamic>? orderData;
//   final String? scratchStatus;

//   OrderDetailView({
//     Key? key,
//     this.orderData,
//     this.scratchStatus,
//   }) : super(key: key);

//   @override
//   _OrderDetailViewState createState() => _OrderDetailViewState();
// }

// class _OrderDetailViewState extends State<OrderDetailView> {
//   /// Responsive design variables
//   double deviceWidth = 0;
//   double deviceHeight = 0;
//   double statusbarHeight = 0;
//   double bottomBarHeight = 0;
//   double appbarHeight = 0;
//   double widthDp = 0;
//   double heightDp = 0;
//   double fontSp = 0;
//   ///////////////////////////////

//   AuthProvider? _authProvider;
//   OrderProvider? _orderProvider;
//   KeicyProgressDialog? _keicyProgressDialog;

//   String? updatedOrderStatus;

//   Map<String, dynamic>? _orderData;

//   @override
//   void initState() {
//     super.initState();

//     /// Responsive design variables
//     deviceWidth = 1.sw;
//     deviceHeight = 1.sh;
//     statusbarHeight = ScreenUtil().statusBarHeight;
//     bottomBarHeight = ScreenUtil().bottomBarHeight;
//     appbarHeight = AppBar().preferredSize.height;
//     widthDp = ScreenUtil().setWidth(1);
//     heightDp = ScreenUtil().setWidth(1);
//     fontSp = ScreenUtil().setSp(1) / ScreenUtil().textScaleFactor;
//     ///////////////////////////////

//     _authProvider = AuthProvider.of(context);
//     _orderProvider = OrderProvider.of(context);
//     _keicyProgressDialog = KeicyProgressDialog.of(context);

//     _orderData = json.decode(json.encode(widget.orderData));
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       // if (_orderData!["status"] == AppConfig.orderStatusData.last["id"] &&
//       //     widget.scratchStatus == "scratch_card_create" &&
//       //     widget.orderData["scratchCard"] != null &&
//       //     widget.orderData["scratchCard"].isNotEmpty &&
//       //     widget.orderData["scratchCard"][0]["status"] == "not_scratched") {
//       //   ScratchCardDialog.show(
//       //     context,
//       //     scratchCardData: _orderData!["scratchCard"][0],
//       //     callback: _scratchCardHadler,
//       //   );
//       // }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, size: heightDp * 20),
//           onPressed: () {
//             Navigator.of(context).pop(updatedOrderStatus);
//           },
//         ),
//         title: Text("Order Detail", style: TextStyle(fontSize: fontSp * 18, color: Colors.black)),
//         elevation: 0,
//       ),
//       body: Container(
//         width: deviceWidth,
//         height: deviceHeight,
//         child: _mainPanel(),
//       ),
//     );
//   }

//   Widget _mainPanel() {
//     String orderStatus = "";
//     for (var i = 0; i < AppConfig.orderStatusData.length; i++) {
//       if (_orderData!["status"] == AppConfig.orderStatusData[i]["id"]) {
//         orderStatus = AppConfig.orderStatusData[i]["name"];
//         break;
//       }
//     }
//     print("${_orderData!["orderId"]}_${_authProvider!.authState.userModel!.id}_${_authProvider!.authState.userModel!.email}");
//     return NotificationListener<OverscrollIndicatorNotification>(
//       onNotification: (notification) {
//         notification.disallowGlow();
//         return true;
//       },
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
//           child: Column(
//             children: [
//               Text(
//                 "${_orderData!["orderId"]}",
//                 style: TextStyle(fontSize: fontSp * 23, color: Colors.black),
//               ),

//               ///
//               SizedBox(height: heightDp * 5),
//               QrCodeWidget(
//                 code: Encrypt.encryptString(
//                   "Order_${_orderData!["orderId"]}_StoreId-${_orderData!["storeId"]}_UserId-${_orderData!["userId"]}",
//                 ),
//                 width: heightDp * 150,
//                 height: heightDp * 150,
//               ),

//               ///
//               SizedBox(height: heightDp * 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () async {
//                       if (await canLaunch(_orderData!["invoicePdfUrl"])) {
//                         await launch(
//                           _orderData!["invoicePdfUrl"],
//                           forceSafariVC: false,
//                           forceWebView: false,
//                         );
//                       } else {
//                         throw 'Could not launch ${_orderData!["invoicePdfUrl"]}';
//                       }
//                     },
//                     child: Image.asset("img/pdf-icon.png", width: heightDp * 40, height: heightDp * 40, fit: BoxFit.cover),
//                   ),
//                   SizedBox(width: widthDp * 30),
//                   GestureDetector(
//                     onTap: () {
//                       Share.share(_orderData!["invoicePdfUrl"]);
//                     },
//                     child: Image.asset(
//                       "img/share-icon.png",
//                       width: heightDp * 40,
//                       height: heightDp * 40,
//                       fit: BoxFit.cover,
//                       color: config.Colors().mainColor(1),
//                     ),
//                   ),
//                   if (_orderData!["status"] == AppConfig.orderStatusData.last["id"] &&
//                       _orderData!["scratchCard"] != null &&
//                       _orderData!["scratchCard"].isNotEmpty &&
//                       _orderData!["scratchCard"][0]["status"] == "not_scratched")
//                     Row(
//                       children: [
//                         SizedBox(width: widthDp * 30),
//                         KeicyRaisedButton(
//                           width: widthDp * 130,
//                           height: heightDp * 40,
//                           borderRadius: heightDp * 8,
//                           color: config.Colors().mainColor(1),
//                           child: Text("Scratch Card", style: TextStyle(fontSize: fontSp * 14, color: Colors.white)),
//                           onPressed: () async {
//                             await ScratchCardDialog.show(
//                               context,
//                               scratchCardId: _orderData!["scratchCardId"],
//                               callback: (Map<String, dynamic> scratchCardData) {
//                                 _orderData!["scratchCard"][0] = scratchCardData;
//                               },
//                             );
//                             setState(() {});
//                           },
//                         ),
//                       ],
//                     ),
//                 ],
//               ),

//               ///
//               SizedBox(height: heightDp * 15),
//               StoreInfoPanel(storeData: _orderData!["store"]),
//               ////
//               SizedBox(height: heightDp * 15),
//               CartListPanel(storeData: _orderData!["store"], orderData: _orderData),
//               Divider(height: 1, thickness: 1, color: Colors.grey.withOpacity(0.6)),

//               ///
//               _orderData!["instructions"] == ""
//                   ? SizedBox()
//                   : Column(
//                       children: [
//                         SizedBox(height: heightDp * 10),
//                         Container(
//                           width: deviceWidth,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(Icons.event_note, size: heightDp * 25, color: Colors.black.withOpacity(0.7)),
//                                   SizedBox(width: widthDp * 10),
//                                   Text(
//                                     "Instruction",
//                                     style: TextStyle(fontSize: fontSp * 18, color: Colors.black),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: heightDp * 5),
//                               Text(
//                                 _orderData!["instructions"],
//                                 style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: heightDp * 10),
//                         Divider(height: 1, thickness: 1, color: Colors.grey.withOpacity(0.6)),
//                       ],
//                     ),

//               ///
//               _orderData!["paymentDetail"]["promocode"] == ""
//                   ? SizedBox()
//                   : Column(
//                       children: [
//                         SizedBox(height: heightDp * 10),
//                         Container(
//                           width: deviceWidth,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Promo code: ",
//                                 style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 _orderData!["paymentDetail"]["promocode"],
//                                 style: TextStyle(fontSize: fontSp * 16, color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: heightDp * 10),
//                         Divider(height: heightDp * 1, thickness: 1, color: Colors.grey.withOpacity(0.6)),
//                       ],
//                     ),

//               ///
//               SizedBox(height: heightDp * 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Order Status: ",
//                     style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     orderStatus,
//                     style: TextStyle(fontSize: fontSp * 16, color: Colors.black),
//                   ),
//                 ],
//               ),
//               if (_orderData!["status"] == AppConfig.orderStatusData[7]["id"] || _orderData!["status"] == AppConfig.orderStatusData[8]["id"])
//                 Column(
//                   children: [
//                     SizedBox(height: heightDp * 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           _orderData!["status"] == AppConfig.orderStatusData[7]["id"] ? "Cancel Reason:" : "Reject Reason: ",
//                           style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.w600),
//                         ),
//                         SizedBox(width: widthDp * 10),
//                         Expanded(
//                           child: Text(
//                             "${_orderData!["reasonForCancelOrReject"]}",
//                             style: TextStyle(fontSize: fontSp * 16, color: Colors.black),
//                             textAlign: TextAlign.right,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//               SizedBox(height: heightDp * 10),
//               Divider(height: heightDp * 1, thickness: 1, color: Colors.grey.withOpacity(0.6)),

//               ///
//               _orderData!["products"] == null || _orderData!["products"].isEmpty
//                   ? SizedBox()
//                   : Column(
//                       children: [
//                         SizedBox(height: heightDp * 10),
//                         Container(
//                           width: deviceWidth,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Order Type: ",
//                                 style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 _orderData!["orderType"],
//                                 style: TextStyle(fontSize: fontSp * 16, color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: heightDp * 10),
//                         Divider(height: heightDp * 1, thickness: 1, color: Colors.grey.withOpacity(0.6)),
//                       ],
//                     ),

//               ///
//               _orderData!["products"] == null ||
//                       _orderData!["products"].isEmpty ||
//                       _orderData!["orderType"] != "Pickup" ||
//                       _orderData!['pickupDateTime'] == null
//                   ? SizedBox()
//                   : Column(
//                       children: [
//                         SizedBox(height: heightDp * 10),
//                         Container(
//                           width: deviceWidth,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Pickup Date:",
//                                 style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 KeicyDateTime.convertDateTimeToDateString(
//                                   dateTime: DateTime.tryParse(_orderData!['pickupDateTime']),
//                                   formats: 'Y-m-d',
//                                   isUTC: false,
//                                 ),
//                                 style: TextStyle(fontSize: fontSp * 16, color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: heightDp * 10),
//                         Divider(height: heightDp * 1, thickness: 1, color: Colors.grey.withOpacity(0.6)),
//                       ],
//                     ),

//               ///
//               _orderData!["products"] == null ||
//                       _orderData!["products"].isEmpty ||
//                       _orderData!["orderType"] != "Delivery" ||
//                       _orderData!['deliveryAddress'] == null
//                   ? SizedBox()
//                   : Column(
//                       children: [
//                         SizedBox(height: heightDp * 10),
//                         Container(
//                           width: deviceWidth,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Delivery Address:",
//                                 style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.w600),
//                               ),
//                               SizedBox(height: heightDp * 5),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "${_orderData!["deliveryAddress"]["addressType"]}",
//                                         style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.bold),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       SizedBox(width: widthDp * 10),
//                                       Text(
//                                         "${(_orderData!["deliveryAddress"]["distance"] / 1000).toStringAsFixed(3)} Km",
//                                         style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: heightDp * 5),
//                                   _orderData!["deliveryAddress"]["building"] == null || _orderData!["deliveryAddress"]["building"] == ""
//                                       ? SizedBox()
//                                       : Column(
//                                           children: [
//                                             Text(
//                                               "${_orderData!["deliveryAddress"]["building"]}",
//                                               style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                             SizedBox(height: heightDp * 5),
//                                           ],
//                                         ),
//                                   Text(
//                                     "${_orderData!["deliveryAddress"]["address"]["address"]}",
//                                     style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   SizedBox(height: heightDp * 10),
//                                   KeicyCheckBox(
//                                     height: heightDp * 25,
//                                     iconColor: Color(0xFF00D18F),
//                                     labelSpacing: widthDp * 20,
//                                     label: "No Contact Delivery",
//                                     labelStyle: TextStyle(fontSize: fontSp * 18, color: Colors.black, fontWeight: FontWeight.w500),
//                                     value: _orderData!["noContactDelivery"],
//                                     readOnly: true,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: heightDp * 10),
//                         Divider(height: heightDp * 1, thickness: 1, color: Colors.grey.withOpacity(0.6)),
//                       ],
//                     ),

//               ///
//               _orderData!["services"] == null || _orderData!["services"].isEmpty || _orderData!['serviceDateTime'] == null
//                   ? SizedBox()
//                   : Column(
//                       children: [
//                         SizedBox(height: heightDp * 10),
//                         Container(
//                           width: deviceWidth,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Service Date:",
//                                 style: TextStyle(fontSize: fontSp * 16, color: Colors.black, fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 KeicyDateTime.convertDateTimeToDateString(
//                                   dateTime: DateTime.tryParse(_orderData!['serviceDateTime']),
//                                   formats: 'Y-m-d h:i A',
//                                   isUTC: false,
//                                 ),
//                                 style: TextStyle(fontSize: fontSp * 16, color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: heightDp * 10),
//                         Divider(height: heightDp * 1, thickness: 1, color: Colors.grey.withOpacity(0.6)),
//                       ],
//                     ),

//               //////
//               SizedBox(height: heightDp * 10),
//               PaymentDetailPanel(orderData: _orderData),

//               ///
//               SizedBox(height: heightDp * 10),

//               if (AppConfig.orderStatusData[1]["id"] == _orderData!["status"])
//                 _placeOrderActionButtonGroup()
//               else if (AppConfig.orderStatusData[2]["id"] == _orderData!["status"])
//                 _acceptOrderActionButtonGroup()
//               else if (AppConfig.orderStatusData[4]["id"] == _orderData!["status"] || AppConfig.orderStatusData[5]["id"] == _orderData!["status"])
//                 _otherButtonGroup(),

//               SizedBox(height: heightDp * 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _placeOrderActionButtonGroup() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         KeicyRaisedButton(
//           width: widthDp * 130,
//           height: heightDp * 30,
//           color: config.Colors().mainColor(1),
//           borderRadius: heightDp * 8,
//           padding: EdgeInsets.symmetric(horizontal: widthDp * 5),
//           child: Text(
//             "Cancel Order",
//             style: TextStyle(fontSize: fontSp * 14, color: Colors.white),
//           ),
//           onPressed: () {
//             _cancelCallback(_orderData!);
//           },
//         ),
//       ],
//     );
//   }

//   Widget _acceptOrderActionButtonGroup() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         if (!_orderData!["payAtStore"] && !_orderData!["cashOnDelivery"])
//           KeicyRaisedButton(
//             width: widthDp * 130,
//             height: heightDp * 30,
//             color: config.Colors().mainColor(1),
//             borderRadius: heightDp * 8,
//             padding: EdgeInsets.symmetric(horizontal: widthDp * 5),
//             child: Text(
//               "Pay Order",
//               style: TextStyle(fontSize: fontSp * 14, color: Colors.white),
//             ),
//             onPressed: () {
//               _payCallback(_orderData!);
//             },
//           ),
//         KeicyRaisedButton(
//           width: widthDp * 130,
//           height: heightDp * 30,
//           color: config.Colors().mainColor(1),
//           borderRadius: heightDp * 8,
//           padding: EdgeInsets.symmetric(horizontal: widthDp * 5),
//           child: Text(
//             "Cancel Order",
//             style: TextStyle(fontSize: fontSp * 14, color: Colors.white),
//           ),
//           onPressed: () {
//             _cancelCallback(_orderData!);
//           },
//         ),
//       ],
//     );
//   }

//   Widget _otherButtonGroup() {
//     return (!_orderData!["payStatus"] && (_orderData!["payAtStore"] || _orderData!["cashOnDelivery"]))
//         ? KeicyRaisedButton(
//             width: widthDp * 130,
//             height: heightDp * 30,
//             color: config.Colors().mainColor(1),
//             borderRadius: heightDp * 8,
//             padding: EdgeInsets.symmetric(horizontal: widthDp * 5),
//             child: Text(
//               "Pay Order",
//               style: TextStyle(fontSize: fontSp * 14, color: Colors.white),
//             ),
//             onPressed: () {
//               _payCallback(_orderData!);
//             },
//           )
//         : SizedBox();
//   }

//   void _cancelCallback(Map<String, dynamic> orderData) {
//     OrderCancelDialog.show(
//       context,
//       tilte: "Order Cancel",
//       content: "Do you want to cancel this order?",
//       callback: (reason) async {
//         await _keicyProgressDialog!.show();
//         Map<String, dynamic> newOrderData = json.decode(json.encode(orderData));
//         newOrderData["reasonForCancelOrReject"] = reason;
//         // var result = await _orderProvider!.changeOrderStatus(
//         //   storeId: orderData["store"]["_id"],
//         //   orderId: orderData["_id"],
//         //   userId: _authProvider!.authState.userModel!.id,
//         //   status: AppConfig.orderStatusData[7]["id"],
//         // );
//         var result = await _orderProvider!.updateOrderData(
//           orderData: newOrderData,
//           status: AppConfig.orderStatusData[7]["id"],
//           changedStatus: false,
//         );
//         await _keicyProgressDialog!.hide();
//         if (result["success"]) {
//           _orderData = result["data"];
//           _orderData!["status"] = AppConfig.orderStatusData[7]["id"];
//           updatedOrderStatus = AppConfig.orderStatusData[7]["id"];
//           setState(() {});
//           SuccessDialog.show(
//             context,
//             heightDp: heightDp,
//             fontSp: fontSp,
//             text: "The order is cancelled",
//           );
//         } else {
//           ErrorDialog.show(
//             context,
//             widthDp: widthDp,
//             heightDp: heightDp,
//             fontSp: fontSp,
//             text: result["message"],
//             callBack: () {
//               _cancelCallback(orderData);
//             },
//           );
//         }
//       },
//     );
//   }

//   void _payCallback(Map<String, dynamic> orderData) async {
//     // var result = await Navigator.of(context).push(
//     //   MaterialPageRoute(
//     //     builder: (BuildContext context) => RazorPayPage(orderData: orderData),
//     //   ),
//     // );

//     // if (result != null) {
//     //   _orderData!["status"] = AppConfig.orderStatusData[3]["id"];
//     //   updatedOrderStatus = AppConfig.orderStatusData[3]["id"];
//     //   setState(() {});
//     // }
//   }
// }
