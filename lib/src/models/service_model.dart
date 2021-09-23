import 'dart:convert';
import 'dart:io';

import "package:equatable/equatable.dart";

class ServiceModel extends Equatable {
  String? id;
  String? name;
  String? description;
  String? category;
  String? provided;
  String? storeId;
  double? price;
  bool? isAvailable;
  double? taxPercentage;
  double? discount;
  bool? showPriceToUsers;
  String? serviceIdentificationCode;
  List<dynamic>? images;
  bool? bargainAvailable;
  bool? isDeleted;
  bool? listonline;
  Map<String, dynamic>? priceAttributes;
  double? margin;
  Map<String, dynamic>? bargainAttributes;
  Map<String, dynamic>? extraCharges;
  List<dynamic>? attributes;
  File? imageFile;

  ServiceModel({
    String? id,
    String? name,
    String? description,
    String? category,
    String? provided,
    String? storeId,
    double? price,
    bool? isAvailable,
    double? taxPercentage,
    double? discount,
    bool? showPriceToUsers,
    String? serviceIdentificationCode,
    List<dynamic>? images,
    bool? bargainAvailable,
    bool? isDeleted,
    bool? listonline,
    Map<String, dynamic>? priceAttributes,
    double? margin,
    Map<String, dynamic>? bargainAttributes,
    Map<String, dynamic>? extraCharges,
    List<dynamic>? attributes,
    File? imageFile,
  }) {
    this.id = id ?? null;
    this.name = name ?? "";
    this.description = description ?? "";
    this.category = category ?? "";
    this.provided = provided ?? "";
    this.storeId = storeId ?? "";
    this.price = price ?? 0;
    this.isAvailable = isAvailable ?? false;
    this.taxPercentage = taxPercentage ?? 0;
    this.discount = discount ?? 0;
    this.showPriceToUsers = showPriceToUsers ?? false;
    this.serviceIdentificationCode = serviceIdentificationCode ?? "";
    this.images = images ?? [];
    this.bargainAvailable = bargainAvailable ?? false;
    this.isDeleted = isDeleted ?? false;
    this.listonline = listonline ?? false;
    this.priceAttributes = priceAttributes ?? Map<String, dynamic>();
    this.margin = margin ?? 0;
    this.bargainAttributes = bargainAttributes ?? Map<String, dynamic>();
    this.extraCharges = extraCharges ?? Map<String, dynamic>();
    this.attributes = attributes ?? [];
    this.imageFile = imageFile ?? null;
  }

  factory ServiceModel.fromJson(Map<String, dynamic> map) {
    return ServiceModel(
      id: map["_id"] ?? map["id"] ?? null,
      name: map["name"] ?? "",
      description: map["description"] ?? "",
      category: map["category"] ?? "",
      provided: map["provided"] ?? "",
      storeId: map["storeId"] ?? "",
      price: map["price"] != null ? double.parse(map["price"].toString()) : 0,
      isAvailable: map["isAvailable"] != null ? json.decode(map["isAvailable"].toString()) : false,
      taxPercentage: map["taxPercentage"] != null ? double.parse(map["taxPercentage"].toString()) : 0,
      discount: map["discount"] != null ? double.parse(map["discount"].toString()) : 0,
      showPriceToUsers: map["showPriceToUsers"] != null ? json.decode(map["showPriceToUsers"].toString()) : false,
      serviceIdentificationCode: map["serviceIdentificationCode"] ?? "",
      images: map["images"] != null
          ? map["images"].runtimeType.toString() == "String"
              ? json.decode(map["images"].toString())
              : map["images"]
          : [],
      bargainAvailable: map["bargainAvailable"] ?? false,
      isDeleted: map["isDeleted"] ?? false,
      listonline: map["listonline"] ?? true,
      priceAttributes: map["priceAttributes"] ?? Map<String, dynamic>(),
      margin: map["margin"] != null ? double.parse(map["margin"].toString()) : 0,
      bargainAttributes: map["bargainAttributes"] ?? Map<String, dynamic>(),
      extraCharges: map["extraCharges"] ?? Map<String, dynamic>(),
      attributes: map["attributes"] ?? [],
      imageFile: map["imageFile"] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id ?? null,
      "id": id ?? null,
      "name": name ?? "",
      "description": description ?? "",
      "category": category ?? "",
      "provided": provided ?? "",
      "storeId": storeId ?? "",
      "price": price != null ? price!.toString() : "0",
      "isAvailable": isAvailable ?? false,
      "taxPercentage": taxPercentage != null ? taxPercentage!.toString() : "0",
      "discount": discount != null ? discount!.toString() : "0",
      "showPriceToUsers": showPriceToUsers ?? false,
      "serviceIdentificationCode": serviceIdentificationCode ?? "",
      "images": images ?? [],
      "bargainAvailable": bargainAvailable ?? false,
      "isDeleted": isDeleted ?? false,
      "listonline": listonline ?? true,
      "priceAttributes": priceAttributes ?? Map<String, dynamic>(),
      "margin": margin != null ? margin!.toString() : "0",
      "bargainAttributes": bargainAttributes ?? Map<String, dynamic>(),
      "extraCharges": extraCharges ?? Map<String, dynamic>(),
      "attributes": attributes ?? [],
    };
  }

  factory ServiceModel.copy(ServiceModel model) {
    return ServiceModel(
      id: model.id,
      name: model.name,
      description: model.description,
      category: model.category,
      provided: model.provided,
      storeId: model.storeId,
      price: model.price,
      isAvailable: model.isAvailable,
      taxPercentage: model.taxPercentage,
      discount: model.discount,
      showPriceToUsers: model.showPriceToUsers,
      serviceIdentificationCode: model.serviceIdentificationCode,
      images: model.images,
      bargainAvailable: model.bargainAvailable,
      isDeleted: model.isDeleted,
      listonline: model.listonline,
      priceAttributes: model.priceAttributes,
      margin: model.margin,
      bargainAttributes: model.bargainAttributes,
      extraCharges: model.extraCharges,
      attributes: model.attributes,
      imageFile: model.imageFile,
    );
  }

  @override
  List<Object> get props => [
        id ?? Object(),
        name!,
        description!,
        category!,
        provided!,
        storeId!,
        price!,
        isAvailable!,
        taxPercentage!,
        discount!,
        showPriceToUsers!,
        serviceIdentificationCode!,
        images!,
        bargainAvailable!,
        isDeleted!,
        listonline!,
        priceAttributes!,
        margin!,
        bargainAttributes!,
        extraCharges!,
        attributes!,
        imageFile ?? Object(),
      ];

  @override
  bool get stringify => true;
}
