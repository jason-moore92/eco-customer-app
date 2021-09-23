// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class PaymentDetailPanel extends StatefulWidget {
//   final Map<String, dynamic>? orderData;

//   PaymentDetailPanel({
//     @required this.orderData,
//   });

//   @override
//   _PaymentDetailPanelState createState() => _PaymentDetailPanelState();
// }

// class _PaymentDetailPanelState extends State<PaymentDetailPanel> {
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
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.orderData!["paymentDetail"] == null || widget.orderData!["paymentDetail"]["toPay"] == 0) {
//       return SizedBox();
//     }

//     int redeemRewardValue = 0;
//     if (widget.orderData!["redeemRewardData"] != null && widget.orderData!["redeemRewardData"]["redeemRewardValue"] != null) {
//       redeemRewardValue = widget.orderData!["redeemRewardData"]["redeemRewardValue"];
//     }

//     int tradeRedeemRewardValue = 0;
//     if (widget.orderData!["redeemRewardData"] != null && widget.orderData!["redeemRewardData"]["tradeRedeemRewardValue"] != null) {
//       tradeRedeemRewardValue = widget.orderData!["redeemRewardData"]["tradeRedeemRewardValue"];
//     }

//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ///
//           Text(
//             "Payment Detail",
//             style: TextStyle(fontSize: fontSp * 18, color: Colors.black, fontWeight: FontWeight.w500),
//           ),

//           ///
//           SizedBox(height: heightDp * 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Total Count",
//                 style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//               ),
//               Text(
//                 "${widget.orderData!["paymentDetail"]["totalQuantity"]}",
//                 style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//               ),
//             ],
//           ),

//           ///
//           Divider(height: heightDp * 15, thickness: 1, color: Colors.black.withOpacity(0.1)),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Total Price",
//                 style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "₹ ${widget.orderData!["paymentDetail"]["totalPriceAfterPromocode"].toStringAsFixed(2)}",
//                     style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                   ),
//                   widget.orderData!["paymentDetail"]["totalPriceBeforePromocode"] == widget.orderData!["paymentDetail"]["totalPriceAfterPromocode"]
//                       ? SizedBox()
//                       : Row(
//                           children: [
//                             SizedBox(width: widthDp * 5),
//                             Text(
//                               "₹ ${widget.orderData!["paymentDetail"]["totalPriceBeforePromocode"].toStringAsFixed(2)}",
//                               style: TextStyle(
//                                 fontSize: fontSp * 12,
//                                 color: Colors.grey,
//                                 decoration: TextDecoration.lineThrough,
//                                 decorationThickness: 2,
//                               ),
//                             ),
//                           ],
//                         ),
//                 ],
//               ),
//             ],
//           ),

//           ///
//           Divider(height: heightDp * 15, thickness: 1, color: Colors.black.withOpacity(0.1)),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Total Item Price",
//                 style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "₹ ${(widget.orderData!["paymentDetail"]["totalPriceAfterPromocode"] - widget.orderData!["paymentDetail"]["totalTax"]).toStringAsFixed(2)}",
//                     style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                   ),
//                   widget.orderData!["paymentDetail"]["totalPriceBeforePromocode"] == widget.orderData!["paymentDetail"]["totalPriceAfterPromocode"]
//                       ? SizedBox()
//                       : Row(
//                           children: [
//                             SizedBox(width: widthDp * 5),
//                             Text(
//                               "₹ ${(widget.orderData!["paymentDetail"]["totalPriceBeforePromocode"] - widget.orderData!["paymentDetail"]["totalTaxBeforePromocode"]).toStringAsFixed(2)}",
//                               style: TextStyle(
//                                 fontSize: fontSp * 12,
//                                 color: Colors.grey,
//                                 decoration: TextDecoration.lineThrough,
//                                 decorationThickness: 2,
//                               ),
//                             ),
//                           ],
//                         ),
//                 ],
//               ),
//             ],
//           ),

//           ///
//           widget.orderData!["paymentDetail"]["promocode"] == null || widget.orderData!["paymentDetail"]["promocode"].isEmpty
//               ? SizedBox()
//               : Column(
//                   children: [
//                     Divider(height: heightDp * 15, thickness: 1, color: Colors.black.withOpacity(0.1)),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Promo code applied",
//                           style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                         ),
//                         Text(
//                           "${widget.orderData!["paymentDetail"]["promocode"]}",
//                           style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//           ///
//           widget.orderData!["paymentDetail"]["deliveryCargeBeforePromocode"] == 0
//               ? SizedBox()
//               : Column(
//                   children: [
//                     Divider(height: heightDp * 15, thickness: 1, color: Colors.black.withOpacity(0.1)),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               "Delivery Price",
//                               style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 _deliveryBreakdownDialog();
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(horizontal: widthDp * 10),
//                                 color: Colors.transparent,
//                                 child: Icon(Icons.info_outline, size: heightDp * 20, color: Colors.black.withOpacity(0.6)),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text(
//                               "₹ ${widget.orderData!["paymentDetail"]["deliveryCargeAfterPromocode"].toStringAsFixed(2)}",
//                               style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                             ),
//                             widget.orderData!["paymentDetail"]["deliveryDiscount"] == 0
//                                 ? SizedBox()
//                                 : Row(
//                                     children: [
//                                       SizedBox(width: widthDp * 5),
//                                       Text(
//                                         "₹ ${widget.orderData!["paymentDetail"]["deliveryCargeBeforePromocode"].toStringAsFixed(2)}",
//                                         style: TextStyle(
//                                           fontSize: fontSp * 12,
//                                           color: Colors.grey,
//                                           decoration: TextDecoration.lineThrough,
//                                           decorationThickness: 2,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//           ///
//           widget.orderData!["paymentDetail"]["tip"] == 0
//               ? SizedBox()
//               : Column(
//                   children: [
//                     Divider(height: heightDp * 15, thickness: 1, color: Colors.black.withOpacity(0.1)),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Tip",
//                           style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                         ),
//                         Text(
//                           "₹ ${widget.orderData!["paymentDetail"]["tip"].toStringAsFixed(2)}",
//                           style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//           ///
//           widget.orderData!["paymentDetail"]["totalTax"] == 0
//               ? SizedBox()
//               : Column(
//                   children: [
//                     Divider(height: heightDp * 15, thickness: 1, color: Colors.black.withOpacity(0.1)),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Tax",
//                           style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                         ),
//                         Text(
//                           "₹ ${widget.orderData!["paymentDetail"]["totalTax"].toStringAsFixed(2)}",
//                           style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//           // widget.orderData!["redeemRewardData"] == null || widget.orderData!["redeemRewardData"]["tradeRedeemRewardValue"] == 0
//           //     ? SizedBox()
//           //     : Column(
//           //         children: [
//           //           Divider(height: heightDp * 15, thickness: 1, color: Colors.black.withOpacity(0.1)),
//           //           Row(
//           //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //             children: [
//           //               Text(
//           //                 "TradeMantri Redeem Reward value",
//           //                 style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//           //               ),
//           //               Text(
//           //                 "₹ ${widget.orderData!["redeemRewardData"]["tradeRedeemRewardValue"]}",
//           //                 style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//           //               ),
//           //             ],
//           //           ),
//           //         ],
//           //       ),

//           ///
//           redeemRewardValue == 0
//               ? SizedBox()
//               : Column(
//                   children: [
//                     Divider(height: heightDp * 15, thickness: 1, color: Colors.black.withOpacity(0.1)),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Redeem Reward Value",
//                           style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                         ),
//                         Text(
//                           "₹ ${redeemRewardValue}",
//                           style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//           Divider(height: heightDp * 15, thickness: 1, color: Colors.black.withOpacity(0.1)),
//           Column(
//             children: [
//               SizedBox(height: heightDp * 5),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "To Pay",
//                     style: TextStyle(fontSize: fontSp * 14, color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "₹ ${(widget.orderData!["paymentDetail"]["toPay"] - redeemRewardValue).toStringAsFixed(2)}",
//                     style: TextStyle(fontSize: fontSp * 14, color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void _deliveryBreakdownDialog() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return BottomSheet(
//           backgroundColor: Colors.transparent,
//           onClosing: () {},
//           builder: (context) {
//             return Column(
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Container(color: Colors.transparent),
//                   ),
//                 ),
//                 Container(
//                   width: deviceWidth,
//                   padding: EdgeInsets.symmetric(horizontal: widthDp * 15, vertical: heightDp * 15),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(topLeft: Radius.circular(heightDp * 20), topRight: Radius.circular(heightDp * 20)),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Delivery Charges Breakdown",
//                             style: TextStyle(fontSize: fontSp * 18, color: Colors.black, fontWeight: FontWeight.w500),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Padding(
//                               padding: EdgeInsets.only(left: widthDp * 10),
//                               child: Icon(Icons.close, size: heightDp * 25, color: Colors.black),
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: heightDp * 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Total distance",
//                             style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                           ),
//                           Text(
//                             "${widget.orderData!["paymentDetail"]["distance"]} Km",
//                             style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: heightDp * 5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Distance Charge",
//                             style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                           ),
//                           Text(
//                             "₹ ${widget.orderData!["paymentDetail"]["deliveryCargeBeforePromocode"].toStringAsFixed(2)}",
//                             style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                           ),
//                         ],
//                       ),
//                       widget.orderData!["paymentDetail"]["deliveryDiscount"] == 0
//                           ? SizedBox()
//                           : Column(
//                               children: [
//                                 SizedBox(height: heightDp * 5),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Distance Discount",
//                                       style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                                     ),
//                                     Text(
//                                       "₹ ${widget.orderData!["paymentDetail"]["deliveryDiscount"].toStringAsFixed(2)}",
//                                       style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                       Divider(height: heightDp * 20, thickness: 1, color: Colors.black.withOpacity(0.1)),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Total",
//                             style: TextStyle(fontSize: fontSp * 14, color: Colors.black, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "₹ ${widget.orderData!["paymentDetail"]["deliveryCargeAfterPromocode"].toStringAsFixed(2)}",
//                             style: TextStyle(fontSize: fontSp * 14, color: Colors.black, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
