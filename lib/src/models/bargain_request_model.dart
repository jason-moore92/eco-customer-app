import "package:equatable/equatable.dart";

import 'index.dart';

class BargainRequestModel extends Equatable {
  String? id;
  String? categoryId;
  StoreModel? storeModel;
  UserModel? userModel;
  String? bargainRequestId;
  List<ProductOrderModel>? products;
  List<ServiceOrderModel>? services;
  bool? isBulkOrder;
  double? offerPrice;
  List<dynamic>? userOfferPriceList;
  List<dynamic>? storeOfferPriceList;
  String? status;
  String? subStatus;
  List<dynamic>? messages;
  List<dynamic>? history;
  DateTime? bargainDateTime;
  bool? isEnabled;
  DateTime? updatedAt;

  BargainRequestModel({
    String? id,
    String? categoryId,
    StoreModel? storeModel,
    UserModel? userModel,
    String? bargainRequestId,
    List<ProductOrderModel>? products,
    List<ServiceOrderModel>? services,
    bool? isBulkOrder,
    double? offerPrice,
    List<dynamic>? userOfferPriceList,
    List<dynamic>? storeOfferPriceList,
    String? status,
    String? subStatus,
    List<dynamic>? messages,
    List<dynamic>? history,
    DateTime? bargainDateTime,
    bool? isEnabled,
    DateTime? updatedAt,
  }) {
    this.id = id ?? null;
    this.categoryId = categoryId ?? "";
    this.storeModel = storeModel ?? null;
    this.userModel = userModel ?? null;
    this.bargainRequestId = bargainRequestId ?? "";
    this.products = products ?? [];
    this.services = services ?? [];
    this.isBulkOrder = isBulkOrder ?? false;
    this.offerPrice = offerPrice ?? 0;
    this.userOfferPriceList = userOfferPriceList ?? [];
    this.storeOfferPriceList = storeOfferPriceList ?? [];
    this.status = status ?? "";
    this.subStatus = subStatus ?? "";
    this.messages = messages ?? [];
    this.history = history ?? [];
    this.bargainDateTime = bargainDateTime ?? null;
    this.isEnabled = isEnabled ?? false;
    this.updatedAt = updatedAt ?? null;
  }

  factory BargainRequestModel.fromJson(Map<String, dynamic> map) {
    List<ProductOrderModel> productModels = [];
    List<ServiceOrderModel> servicetModels = [];
    for (var i = 0; i < map["products"].length; i++) {
      productModels.add(ProductOrderModel.fromJson(map["products"][i]));
    }

    for (var i = 0; i < map["services"].length; i++) {
      servicetModels.add(ServiceOrderModel.fromJson(map["services"][i]));
    }

    return BargainRequestModel(
      id: map["_id"] ?? null,
      categoryId: map["categoryId"] ?? "",
      storeModel: map["store"] != null ? StoreModel.fromJson(map["store"]) : null,
      userModel: map["user"] != null ? UserModel.fromJson(map["user"]) : null,
      bargainRequestId: map["bargainRequestId"] ?? "",
      products: productModels,
      services: servicetModels,
      isBulkOrder: map["isBulkOrder"] ?? false,
      offerPrice: map["offerPrice"] != null ? double.parse(map["offerPrice"].toString()) : 0,
      userOfferPriceList: map["userOfferPriceList"] ?? [],
      storeOfferPriceList: map["storeOfferPriceList"] ?? [],
      status: map["status"] ?? "",
      subStatus: map["subStatus"] ?? "",
      messages: map["messages"] ?? [],
      history: map["history"] ?? [],
      bargainDateTime: map["bargainDateTime"] != null ? DateTime.tryParse(map["bargainDateTime"])!.toLocal() : null,
      isEnabled: map["isEnabled"] ?? false,
      updatedAt: map["updatedAt"] != null ? DateTime.tryParse(map["updatedAt"])!.toLocal() : null,
    );
  }

  Map<String, dynamic> toJson() {
    List<dynamic> productJson = [];
    List<dynamic> serviceJson = [];

    for (var i = 0; i < products!.length; i++) {
      productJson.add(products![i].toJson());
    }

    for (var i = 0; i < services!.length; i++) {
      serviceJson.add(services![i].toJson());
    }

    return {
      "_id": id ?? null,
      "categoryId": categoryId ?? "",
      "storeId": storeModel != null ? storeModel!.id : "",
      "userId": userModel != null ? userModel!.id : "",
      "bargainRequestId": bargainRequestId ?? "",
      "products": productJson,
      "services": serviceJson,
      "isBulkOrder": isBulkOrder ?? false,
      "offerPrice": offerPrice != null ? offerPrice : 0,
      "userOfferPriceList": userOfferPriceList ?? [],
      "storeOfferPriceList": storeOfferPriceList ?? [],
      "status": status ?? "",
      "subStatus": subStatus ?? "",
      "messages": messages ?? [],
      "history": history ?? [],
      "bargainDateTime": bargainDateTime != null ? bargainDateTime!.toUtc().toIso8601String() : null,
      "isEnabled": isEnabled ?? false,
      "updatedAt": updatedAt != null ? updatedAt!.toUtc().toIso8601String() : null,
    };
  }

  factory BargainRequestModel.copy(BargainRequestModel model) {
    return BargainRequestModel(
      id: model.id,
      categoryId: model.categoryId,
      storeModel: model.storeModel,
      userModel: model.userModel,
      bargainRequestId: model.bargainRequestId,
      products: model.products,
      services: model.services,
      isBulkOrder: model.isBulkOrder,
      offerPrice: model.offerPrice,
      userOfferPriceList: model.userOfferPriceList,
      storeOfferPriceList: model.storeOfferPriceList,
      status: model.status,
      subStatus: model.subStatus,
      messages: model.messages,
      history: model.history,
      bargainDateTime: model.bargainDateTime,
      isEnabled: model.isEnabled,
      updatedAt: model.updatedAt,
    );
  }

  @override
  List<Object> get props => [
        id ?? Object(),
        categoryId!,
        storeModel!,
        userModel!,
        bargainRequestId!,
        products!,
        services!,
        isBulkOrder!,
        offerPrice!,
        userOfferPriceList!,
        storeOfferPriceList!,
        status!,
        subStatus!,
        messages!,
        history!,
        bargainDateTime ?? Object(),
        isEnabled!,
        updatedAt ?? Object(),
      ];

  @override
  bool get stringify => true;
}
