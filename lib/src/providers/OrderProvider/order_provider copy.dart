// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:trapp/config/config.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:trapp/src/ApiDataProviders/index.dart';
// import 'package:trapp/src/ApiDataProviders/review_and_rating_api_provider.dart';
// import 'package:trapp/src/helpers/encrypt.dart';
// import 'package:trapp/src/helpers/price_functions.dart';
// import 'package:trapp/src/providers/AppDataProvider/index.dart';
// import 'package:random_string/random_string.dart';

// import 'index.dart';

// class OrderProvider extends ChangeNotifier {
//   static OrderProvider of(BuildContext context, {bool listen = false}) => Provider.of<OrderProvider>(context, listen: listen);

//   OrderState _orderState = OrderState.init();
//   OrderState get orderState => _orderState;

//   SharedPreferences _prefs;
//   SharedPreferences get prefs => _prefs;

//   void setOrderState(OrderState orderState, {bool isNotifiable = true}) {
//     if (_orderState != orderState) {
//       _orderState = orderState;
//       if (isNotifiable) notifyListeners();
//     }
//   }

//   Future<void> addOrder({@required Map<String, dynamic> orderData, @required String category}) async {
//     orderData = json.decode(json.encode(orderData));
//     orderData.remove("_id");
//     if (orderData["storeId"] == null) {
//       orderData["storeId"] = orderData["store"]["_id"];
//     }
//     try {
//       orderData = PriceFunctions.calculateINRPromocode(orderData: orderData);
//       double productPriceForAllOrderQuantityBeforeTax = 0;
//       double productPriceForAllOrderQuantityAfterTax = 0;
//       bool haveCustomProduct = false;
//       for (var i = 0; i < orderData["products"].length; i++) {
//         if (orderData["products"][i].isEmpty) continue;
//         Map<String, dynamic> newData = Map<String, dynamic>();
//         if (orderData["products"][i]["data"]["_id"] == null) {
//           newData["name"] = orderData["products"][i]["data"]["name"];
//           newData["orderQuantity"] = orderData["products"][i]["orderQuantity"];
//           orderData["products"][i] = newData;
//           haveCustomProduct = true;
//         } else {
//           var result = PriceFunctions.getPriceDataForProduct(orderData: orderData, data: orderData["products"][i]["data"]);
//           newData["id"] = orderData["products"][i]["data"]["_id"];
//           newData["orderQuantity"] = orderData["products"][i]["orderQuantity"];
//           newData["name"] = orderData["products"][i]["data"]["name"];
//           newData["description"] = orderData["products"][i]["data"]["description"];
//           newData["images"] = orderData["products"][i]["data"]["images"];
//           newData["category"] = orderData["products"][i]["data"]["category"];
//           newData["brand"] = orderData["products"][i]["data"]["brand"];
//           newData["productIdentificationCode"] = orderData["products"][i]["data"]["productIdentificationCode"];
//           newData["price"] = double.parse(orderData["products"][i]["data"]["price"].toString());
//           newData["discount"] =
//               orderData["products"][i]["data"]["discount"] == null ? 0 : double.parse(orderData["products"][i]["data"]["discount"].toString());
//           newData["promocodeDiscount"] = result["promocodeDiscount"];
//           newData["taxPrice"] = result["taxPrice"];
//           newData["priceFor1OrderQuantityBeforeTax"] = newData["price"] - newData["discount"] - newData["promocodeDiscount"];
//           newData["priceFor1OrderQuantityAfterTax"] = newData["price"] - newData["discount"] - newData["promocodeDiscount"] + newData["taxPrice"];
//           newData["quantity"] = orderData["products"][i]["data"]["quantity"];
//           newData["quantityType"] = orderData["products"][i]["data"]["quantityType"];
//           newData["taxPercentage"] = orderData["products"][i]["data"]["taxPercentage"];
//           orderData["products"][i] = newData;
//           productPriceForAllOrderQuantityBeforeTax += newData["priceFor1OrderQuantityBeforeTax"] * newData["orderQuantity"];
//           productPriceForAllOrderQuantityAfterTax += newData["priceFor1OrderQuantityAfterTax"] * newData["orderQuantity"];
//         }
//       }
//       if (haveCustomProduct) {
//         productPriceForAllOrderQuantityBeforeTax = 0;
//         productPriceForAllOrderQuantityAfterTax = 0;
//       }

//       double servicePriceForAllOrderQuantityBeforeTax = 0;
//       double servicePriceForAllOrderQuantityAfterTax = 0;
//       bool haveCustomService = false;
//       for (var i = 0; i < orderData["services"].length; i++) {
//         if (orderData["services"][i].isEmpty) continue;
//         Map<String, dynamic> newData = Map<String, dynamic>();
//         if (orderData["services"][i]["data"]["_id"] == null) {
//           newData["name"] = orderData["services"][i]["data"]["name"];
//           haveCustomService = true;
//           newData["orderQuantity"] = orderData["services"][i]["orderQuantity"];
//           orderData["services"][i] = newData;
//         } else {
//           var result = PriceFunctions.getPriceDataForProduct(orderData: orderData, data: orderData["services"][i]["data"]);
//           newData["id"] = orderData["services"][i]["data"]["_id"];
//           newData["orderQuantity"] = orderData["services"][i]["orderQuantity"];
//           newData["name"] = orderData["services"][i]["data"]["name"];
//           newData["description"] = orderData["services"][i]["data"]["description"];
//           newData["images"] = orderData["services"][i]["data"]["images"];
//           newData["category"] = orderData["services"][i]["data"]["category"];
//           newData["provided"] = orderData["services"][i]["data"]["provided"];
//           newData["price"] = double.parse(orderData["services"][i]["data"]["price"].toString());
//           newData["discount"] =
//               orderData["services"][i]["data"]["discount"] == null ? 0 : double.parse(orderData["services"][i]["data"]["discount"].toString());
//           newData["promocodeDiscount"] = result["promocodeDiscount"];
//           newData["taxPrice"] = result["taxPrice"];
//           newData["priceFor1OrderQuantityBeforeTax"] = newData["price"] - newData["discount"] - newData["promocodeDiscount"];
//           newData["priceFor1OrderQuantityAfterTax"] = newData["price"] - newData["discount"] - newData["promocodeDiscount"] + newData["taxPrice"];
//           newData["priceToPay"] = newData["price"] - newData["discount"] - newData["promocodeDiscount"] + newData["taxPrice"];
//           newData["taxPercentage"] = orderData["services"][i]["data"]["taxPercentage"];
//           orderData["services"][i] = newData;
//           servicePriceForAllOrderQuantityBeforeTax += newData["priceFor1OrderQuantityBeforeTax"] * newData["orderQuantity"];
//           servicePriceForAllOrderQuantityAfterTax += newData["priceFor1OrderQuantityAfterTax"] * newData["orderQuantity"];
//         }
//       }

//       if (haveCustomService) {
//         servicePriceForAllOrderQuantityBeforeTax = 0;
//         servicePriceForAllOrderQuantityAfterTax = 0;
//       }

//       if (haveCustomService || haveCustomService) {
//         orderData["productPriceForAllOrderQuantityBeforeTax"] = 0;
//         orderData["productPriceForAllOrderQuantityAfterTax"] = 0;
//         orderData["servicePriceForAllOrderQuantityBeforeTax"] = 0;
//         orderData["servicePriceForAllOrderQuantityAfterTax"] = 0;
//         orderData["paymentDetail"] = {
//           "promocode": orderData["paymentDetail"]["promocode"],
//           "distance": orderData["paymentDetail"]["distance"],
//           "totalQuantity": orderData["paymentDetail"]["totalQuantity"],
//           "totalOriginPrice": 0,
//           "totalPrice": 0,
//           "deliveryCargeBeforeDiscount": 0,
//           "deliveryCargeAfterDiscount": 0,
//           "deliveryDiscount": 0,
//           "tip": 0,
//           "totalTax": 0,
//           "totalTaxBeforeDiscount": 0,
//           "toPay": 0,
//         };
//       } else {
//         orderData["productPriceForAllOrderQuantityBeforeTax"] = productPriceForAllOrderQuantityBeforeTax.toStringAsFixed(2);
//         orderData["productPriceForAllOrderQuantityAfterTax"] = productPriceForAllOrderQuantityAfterTax.toStringAsFixed(2);
//         orderData["servicePriceForAllOrderQuantityBeforeTax"] = servicePriceForAllOrderQuantityBeforeTax.toStringAsFixed(2);
//         orderData["servicePriceForAllOrderQuantityAfterTax"] = servicePriceForAllOrderQuantityAfterTax.toStringAsFixed(2);
//       }
//       orderData["status"] = AppConfig.orderStatusData[1]["id"];
//       orderData["category"] = category;
//       orderData["orderId"] = "TM-" + randomAlphaNumeric(12);

//       ///  add promocode
//       if (orderData["promocode"] != null) {
//         Map<String, dynamic> tmp = Map<String, dynamic>();
//         tmp["id"] = orderData["promocode"]["_id"];
//         tmp["promocodeType"] = orderData["promocode"]["promocodeType"];
//         tmp["promocodeCode"] = orderData["promocode"]["promocodeCode"];
//         tmp["promocodeValue"] = orderData["promocode"]["promocodeValue"];
//         orderData["promocode"] = tmp;
//       }

//       if (orderData["products"].isEmpty && orderData["services"].isNotEmpty) {
//         orderData["orderType"] = "Service";
//       }

//       var result = await OrderApiProvider.addOrder(
//         orderData: orderData,
//         qrCode: Encrypt.encryptString("Order_${orderData["orderId"]}_StoreId-${orderData["storeId"]}_UserId-${orderData["userId"]}"),
//       );

//       if (result["success"]) {
//         _orderState = _orderState.update(
//           progressState: 2,
//           newOrderData: result["data"],
//         );
//       } else {
//         _orderState = _orderState.update(
//           progressState: -1,
//           message: result["message"],
//         );
//       }
//     } catch (e) {
//       _orderState = _orderState.update(
//         progressState: -1,
//         message: e.toString(),
//       );
//     }

//     notifyListeners();
//   }

//   Future<void> getOrderData({@required String userId, @required String status, String searchKey = ""}) async {
//     Map<String, dynamic> orderListData = _orderState.orderListData;
//     Map<String, dynamic> orderMetaData = _orderState.orderMetaData;
//     try {
//       if (orderListData[status] == null) orderListData[status] = [];
//       if (orderMetaData[status] == null) orderMetaData[status] = Map<String, dynamic>();

//       var result;

//       result = await OrderApiProvider.getOrderData(
//         userId: userId,
//         status: status,
//         searchKey: searchKey,
//         page: orderMetaData[status].isEmpty ? 1 : (orderMetaData[status]["nextPage"] ?? 1),
//         limit: AppConfig.countLimitForList,
//         // limit: 1,
//       );

//       if (result["success"]) {
//         for (var i = 0; i < result["data"]["docs"].length; i++) {
//           orderListData[status].add(result["data"]["docs"][i]);
//         }
//         result["data"].remove("docs");
//         orderMetaData[status] = result["data"];

//         _orderState = _orderState.update(
//           progressState: 2,
//           orderListData: orderListData,
//           orderMetaData: orderMetaData,
//         );
//       } else {
//         _orderState = _orderState.update(
//           progressState: 2,
//         );
//       }
//     } catch (e) {
//       _orderState = _orderState.update(
//         progressState: 2,
//       );
//     }
//     Future.delayed(Duration(milliseconds: 500), () {
//       notifyListeners();
//     });
//   }

//   Future<dynamic> changeOrderStatus({
//     @required String storeId,
//     @required String orderId,
//     @required String userId,
//     @required String status,
//     @required String storeName,
//   }) async {
//     try {
//       var result = await OrderApiProvider.changeOrderStatus(
//         orderId: orderId,
//         userId: userId,
//         status: status,
//         storeName: storeName,
//         storeId: storeId,
//       );
//       if (result["success"]) {
//         _orderState = _orderState.update(
//           progressState: 1,
//           orderListData: Map<String, dynamic>(),
//           orderMetaData: Map<String, dynamic>(),
//         );
//         notifyListeners();

//         getOrderData(
//           userId: userId,
//           status: status,
//         );

//         return result;
//       } else {
//         _orderState = _orderState.update(
//           progressState: -1,
//           message: result["message"],
//         );
//       }
//     } catch (e) {
//       _orderState = _orderState.update(
//         progressState: -1,
//         message: e.toString(),
//       );
//     }

//     notifyListeners();
//   }

//   // Future<void> getDashboardDataByUser({@required String userId, String storeCategoryId = ""}) async {
//   //   try {
//   //     var result = await OrderApiProvider.getDashboardDataByUser(userId: userId, storeCategoryId: storeCategoryId);
//   //     if (result["success"]) {
//   //       _orderState = _orderState.update(
//   //         dashboardOrderData: result["data"],
//   //       );
//   //     } else {}
//   //   } catch (e) {}
//   // }
// }
