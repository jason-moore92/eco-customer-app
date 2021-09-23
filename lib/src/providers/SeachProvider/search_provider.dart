import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp/config/config.dart';
import 'package:trapp/src/ApiDataProviders/index.dart';

import 'index.dart';

class SearchProvider extends ChangeNotifier {
  static SearchProvider of(BuildContext context, {bool listen = false}) => Provider.of<SearchProvider>(context, listen: listen);

  SearchState _searchPageState = SearchState.init();
  SearchState get searchPageState => _searchPageState;

  void setSearchState(SearchState searchPageState, {bool isNotifiable = true}) {
    if (_searchPageState != searchPageState) {
      _searchPageState = searchPageState;
      if (isNotifiable) notifyListeners();
    }
  }

  Future<void> getStoreList({
    @required String? categoryId,
    @required Map<String, dynamic>? location,
    @required int? distance,
    String? searchKey = "",
  }) async {
    Map<String, dynamic> storeMetaData = _searchPageState.storeMetaData!;
    Map<String, dynamic> storeList = _searchPageState.storeList!;

    if (storeMetaData[categoryId] == null) storeMetaData[categoryId!] = Map<String, dynamic>();
    if (storeList[categoryId] == null) storeList[categoryId!] = [];

    var result = await StoreApiProvider.getStoreList(
      categoryId: categoryId,
      location: location,
      distance: distance,
      page: storeMetaData[categoryId]["nextPage"] ?? 1,
      searchKey: searchKey!,
    );

    if (result["success"]) {
      storeList[categoryId].addAll(result["data"]["docs"]);
      result["data"].remove("docs");
      storeMetaData[categoryId!] = result["data"];

      _searchPageState = _searchPageState.update(
        progressState: 2,
        message: "",
        storeList: storeList,
        storeMetaData: storeMetaData,
      );
    } else {
      _searchPageState = _searchPageState.update(
        progressState: -1,
        message: result["messsage"],
      );
    }

    notifyListeners();
  }

  Future<void> getProductList({
    @required String? categoryId,
    @required Map<String, dynamic>? location,
    @required int? distance,
    String? searchKey = "",
  }) async {
    Map<String, dynamic> productMetaData = _searchPageState.productMetaData!;
    Map<String, dynamic> productList = _searchPageState.productList!;

    if (productMetaData[categoryId] == null) productMetaData[categoryId!] = Map<String, dynamic>();
    if (productList[categoryId] == null) productList[categoryId!] = [];

    var result = await ProductApiProvider.getProductListByStoreCategory(
      categoryId: categoryId,
      location: location,
      distance: distance,
      page: productMetaData[categoryId]["nextPage"] ?? 1,
      searchKey: searchKey!,
      limit: AppConfig.countLimitForList,
    );

    if (result["success"]) {
      productList[categoryId].addAll(result["data"]["docs"]);
      result["data"].remove("docs");
      productMetaData[categoryId!] = result["data"];

      _searchPageState = _searchPageState.update(
        progressState: 2,
        message: "",
        productList: productList,
        productMetaData: productMetaData,
      );
    } else {
      _searchPageState = _searchPageState.update(
        progressState: 2,
        message: result["messsage"],
      );
    }

    notifyListeners();
  }

  Future<void> getServiceList({
    @required String? categoryId,
    @required Map<String, dynamic>? location,
    @required int? distance,
    String? searchKey = "",
  }) async {
    Map<String, dynamic> serviceList = _searchPageState.serviceList!;
    Map<String, dynamic> serviceMetaData = _searchPageState.serviceMetaData!;

    if (serviceMetaData[categoryId] == null) serviceMetaData[categoryId!] = Map<String, dynamic>();
    if (serviceList[categoryId] == null) serviceList[categoryId!] = [];

    var result = await ServiceApiProvider.getServiceListByStoreCategory(
      categoryId: categoryId,
      location: location,
      distance: distance,
      page: serviceMetaData[categoryId]["nextPage"] ?? 1,
      searchKey: searchKey!,
      limit: AppConfig.countLimitForList,
    );

    if (result["success"]) {
      serviceList[categoryId].addAll(result["data"]["docs"]);
      result["data"].remove("docs");
      serviceMetaData[categoryId!] = result["data"];

      _searchPageState = _searchPageState.update(
        progressState: 2,
        message: "",
        serviceList: serviceList,
        serviceMetaData: serviceMetaData,
      );
    } else {
      _searchPageState = _searchPageState.update(
        progressState: 2,
        message: result["messsage"],
      );
    }

    notifyListeners();
  }

  Future<void> getCouponList({
    @required String? categoryId,
    @required Map<String, dynamic>? location,
    @required int? distance,
    String? searchKey = "",
  }) async {
    Map<String, dynamic> couponList = _searchPageState.couponList!;
    Map<String, dynamic> couponMetaData = _searchPageState.couponMetaData!;

    if (couponMetaData[categoryId] == null) couponMetaData[categoryId!] = Map<String, dynamic>();
    if (couponList[categoryId] == null) couponList[categoryId!] = [];

    var result = await CouponsApiProvider.getCouponsByStoreCategory(
      categoryId: categoryId,
      location: location,
      distance: distance,
      page: couponMetaData[categoryId]["nextPage"] ?? 1,
      searchKey: searchKey!,
      limit: AppConfig.countLimitForList,
    );

    if (result["success"]) {
      couponList[categoryId].addAll(result["data"]["docs"]);
      result["data"].remove("docs");
      couponMetaData[categoryId!] = result["data"];

      _searchPageState = _searchPageState.update(
        progressState: 2,
        message: "",
        couponList: couponList,
        couponMetaData: couponMetaData,
      );
    } else {
      _searchPageState = _searchPageState.update(
        progressState: 2,
        message: result["messsage"],
      );
    }

    notifyListeners();
  }
}
