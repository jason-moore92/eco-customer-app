import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trapp/src/ApiDataProviders/index.dart';
import 'package:trapp/src/helpers/encrypt.dart';
import 'package:trapp/src/helpers/price_functions.dart';
import 'package:random_string/random_string.dart';
import 'package:trapp/src/models/index.dart';

import 'index.dart';

class OrderProvider extends ChangeNotifier {
  static OrderProvider of(BuildContext context, {bool listen = false}) => Provider.of<OrderProvider>(context, listen: listen);

  OrderState _orderState = OrderState.init();
  OrderState get orderState => _orderState;

  SharedPreferences? _prefs;
  SharedPreferences? get prefs => _prefs;

  void setOrderState(OrderState orderState, {bool isNotifiable = true}) {
    if (_orderState != orderState) {
      _orderState = orderState;
      if (isNotifiable) notifyListeners();
    }
  }

  Future<void> addOrder({
    @required OrderModel? orderModel,
    @required String? category,
    @required String? status,
  }) async {
    orderModel = OrderModel.copy(orderModel!);
    try {
      // bool haveCustomProduct = false;
      // for (var i = 0; i < orderModel.products!.length; i++) {
      //   if (orderModel.products![i].productModel!.id == "") {
      //     // newData["name"] = orderModel.products![i]["data"]["name"];
      //     // newData["orderQuantity"] = orderModel.products![i]["orderQuantity"];
      //     // orderModel.products![i] = newData;
      //     haveCustomProduct = true;
      //   }
      // }

      // bool haveCustomService = false;
      // for (var i = 0; i < orderModel.services!.length; i++) {
      //   if (orderModel.services![i].serviceModel!.id == null) {
      //     // newData["name"] = orderModel.services![i]["data"]["name"];
      //     // newData["orderQuantity"] = orderModel.services![i]["orderQuantity"];
      //     // orderModel.services![i] = newData;
      //     haveCustomService = true;
      //   }
      // }

      // if (haveCustomService || haveCustomService) {
      //   // orderModel["productPriceForAllOrderQuantityBeforeTax"] = 0;
      //   // orderModel["productPriceForAllOrderQuantityAfterTax"] = 0;
      //   // orderModel["servicePriceForAllOrderQuantityBeforeTax"] = 0;
      //   // orderModel["servicePriceForAllOrderQuantityAfterTax"] = 0;
      //   // orderModel.paymentDetail = {
      //   //   "promocode": orderModel.paymentDetail["promocode"],
      //   //   "distance": orderModel.paymentDetail["distance"],
      //   //   "totalQuantity": orderModel.paymentDetail["totalQuantity"],
      //   //   "totalOriginPrice": 0,
      //   //   "totalPrice": 0,
      //   //   "deliveryCargeBeforeDiscount": 0,
      //   //   "deliveryCargeAfterDiscount": 0,
      //   //   "deliveryDiscount": 0,
      //   //   "tip": 0,
      //   //   "totalTax": 0,
      //   //   "totalTaxBeforeDiscount": 0,
      //   //   "toPay": 0,
      //   // };
      // }
      orderModel.status = status;
      orderModel.category = category;
      orderModel.orderId = "TM-" + randomAlphaNumeric(12);

      if (orderModel.products!.isEmpty && orderModel.services!.isNotEmpty) {
        orderModel.orderType = "Service";
      }

      /// --- tax Tyepe
      if (orderModel.orderType == "Pickup") {
        orderModel.paymentDetail!.taxType = "SGST";
      } else if (orderModel.orderType == "Delivery" &&
          orderModel.deliveryAddress!.address!.state.toString().toLowerCase() == orderModel.storeModel!.state!.toString().toLowerCase()) {
        orderModel.paymentDetail!.taxType = "SGST";
      } else if (orderModel.orderType == "Delivery" &&
          orderModel.deliveryAddress!.address!.state.toString().toLowerCase() != orderModel.storeModel!.state!.toString().toLowerCase()) {
        orderModel.paymentDetail!.taxType = "IGST";
      }

      if (orderModel.paymentDetail!.totalTaxAfterDiscount! > 0) {
        orderModel.paymentDetail!.taxBreakdown = [
          {"type": "CGST", "value": (orderModel.paymentDetail!.totalTaxAfterDiscount! / 2).toStringAsFixed(2)},
          {"type": orderModel.paymentDetail!.taxType!, "value": (orderModel.paymentDetail!.totalTaxAfterDiscount! / 2).toStringAsFixed(2)}
        ];
      }
      ///////////////////
      if (orderModel.redeemRewardData == null || orderModel.redeemRewardData!["sumRewardPoint"] == null) {
        orderModel.redeemRewardData = Map<String, dynamic>();
        orderModel.redeemRewardData!["sumRewardPoint"] = 0;
        orderModel.redeemRewardData!["redeemRewardValue"] = 0;
        orderModel.redeemRewardData!["redeemRewardPoint"] = 0;
        orderModel.redeemRewardData!["tradeSumRewardPoint"] = 0;
        orderModel.redeemRewardData!["tradeRedeemRewardPoint"] = 0;
        orderModel.redeemRewardData!["tradeRedeemRewardValue"] = 0;
      }
      ////

      var result = await OrderApiProvider.addOrder(
        orderData: orderModel.toJson(),
        qrCode: Encrypt.encryptString("Order_${orderModel.orderId}_StoreId-${orderModel.storeModel!.id}_UserId-${orderModel.userModel!.id}"),
      );

      if (result["success"]) {
        OrderModel newOrderModel = OrderModel.fromJson(result["data"]);
        newOrderModel.storeModel = orderModel.storeModel;
        newOrderModel.userModel = orderModel.userModel;

        _orderState = _orderState.update(
          progressState: 2,
          newOrderModel: newOrderModel,
        );
      } else {
        _orderState = _orderState.update(
          progressState: -1,
          message: result["message"],
        );
      }
    } catch (e) {
      _orderState = _orderState.update(
        progressState: -1,
        message: e.toString(),
      );
    }

    notifyListeners();
  }

  Future<void> getOrderData({@required String? userId, @required String? status, String searchKey = ""}) async {
    Map<String, dynamic> orderListData = _orderState.orderListData!;
    Map<String, dynamic> orderMetaData = _orderState.orderMetaData!;
    try {
      if (orderListData[status] == null) orderListData[status!] = [];
      if (orderMetaData[status] == null) orderMetaData[status!] = Map<String, dynamic>();

      var result;

      result = await OrderApiProvider.getOrderData(
        userId: userId,
        status: status,
        searchKey: searchKey,
        page: orderMetaData[status].isEmpty ? 1 : (orderMetaData[status]["nextPage"] ?? 1),
        limit: AppConfig.countLimitForList,
        // limit: 1,
      );

      if (result["success"]) {
        for (var i = 0; i < result["data"]["docs"].length; i++) {
          orderListData[status].add(result["data"]["docs"][i]);
        }
        result["data"].remove("docs");
        orderMetaData[status!] = result["data"];

        _orderState = _orderState.update(
          progressState: 2,
          orderListData: orderListData,
          orderMetaData: orderMetaData,
        );
      } else {
        _orderState = _orderState.update(
          progressState: 2,
        );
      }
    } catch (e) {
      _orderState = _orderState.update(
        progressState: 2,
      );
    }
    notifyListeners();
  }

  // Future<dynamic> changeOrderStatus({
  //   @required String storeId,
  //   @required String orderId,
  //   @required String userId,
  //   @required String status,
  // }) async {
  //   try {
  //     var result = await OrderApiProvider.changeOrderStatus(
  //       orderId: orderId,
  //       userId: userId,
  //       status: status,
  //       storeId: storeId,
  //     );
  //     if (result["success"]) {
  //       _orderState = _orderState.update(
  //         progressState: 1,
  //         orderListData: Map<String, dynamic>(),
  //         orderMetaData: Map<String, dynamic>(),
  //       );

  //       // getOrderData(
  //       //   userId: userId,
  //       //   status: status,
  //       // );

  //       return result;
  //     } else {
  //       _orderState = _orderState.update(
  //         progressState: -1,
  //         message: result["message"],
  //       );
  //     }
  //   } catch (e) {
  //     _orderState = _orderState.update(
  //       progressState: -1,
  //       message: e.toString(),
  //     );
  //   }

  //   notifyListeners();
  // }

  Future<dynamic> updateOrderData({
    @required Map<String, dynamic>? orderData,
    @required String? status,
    bool changedStatus = true,
  }) async {
    var result = await OrderApiProvider.updateOrderData(
      orderData: orderData,
      status: status,
      changedStatus: changedStatus,
      signature: '',
    );
    if (result["success"]) {
      _orderState = _orderState.update(
        progressState: 1,
        orderListData: Map<String, dynamic>(),
        orderMetaData: Map<String, dynamic>(),
      );
    }

    return result;
  }
}
