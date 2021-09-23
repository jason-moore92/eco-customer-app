import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp/src/ApiDataProviders/index.dart';
import 'package:trapp/src/providers/AppDataProvider/index.dart';

import 'index.dart';

class StoreCategoriesProvider extends ChangeNotifier {
  static StoreCategoriesProvider of(BuildContext context, {bool listen = false}) => Provider.of<StoreCategoriesProvider>(context, listen: listen);

  StoreCategoriesState _searchPageState = StoreCategoriesState.init();
  StoreCategoriesState get searchPageState => _searchPageState;

  void setStoreCategoriesState(StoreCategoriesState searchPageState, {bool isNotifiable = true}) {
    if (_searchPageState != searchPageState) {
      _searchPageState = searchPageState;
      if (isNotifiable) notifyListeners();
    }
  }

  Future<void> getStoreList({
    @required String? categoryId,
    @required Map<String, dynamic>? location,
    @required int? distance,
  }) async {
    Map<String, dynamic> storeMetaData = _searchPageState.storeMetaData!;
    Map<String, dynamic> storeList = _searchPageState.storeList!;

    if (storeMetaData[categoryId] == null) storeMetaData[categoryId!] = Map<String, dynamic>();
    if (storeList[categoryId] == null) storeList[categoryId!] = [];

    // if (_searchPageState.storeMetaData[categoryId].isNotEmpty && _searchPageState.storeMetaData[categoryId]["nextPage"] == null) {
    //   _searchPageState = _searchPageState.update(
    //     progressState: 2,
    //     message: "",
    //     storeList: storeList,
    //     storeMetaData: storeMetaData,
    //   );
    //   notifyListeners();
    //   return;
    // }

    var result = await StoreApiProvider.getStoreList(
      categoryId: categoryId,
      location: location,
      distance: distance,
      page: storeMetaData[categoryId]["nextPage"] ?? 1,
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

  /// get store list
  void getCategoryList({
    @required AppDataProvider? appDataProvider,
    @required int? distance,
    @required String? userId,
    @required Map<String, dynamic>? currentLocation,
    String searchKey = "",
  }) async {
    try {
      List<dynamic> categoryList = await appDataProvider!.getCategoryListData(
        distance: distance,
        currentLocation: currentLocation,
        searchKey: searchKey,
      );

      List<dynamic> _categorySearchKeywords = appDataProvider.prefs!.getString("category_search_keywords") == null
          ? []
          : json.decode(appDataProvider.prefs!.getString("category_search_keywords")!);
      if (categoryList.isNotEmpty && searchKey != "" && (_categorySearchKeywords.indexWhere((str) => str == searchKey) == -1)) {
        if (_categorySearchKeywords.length >= 5) {
          _categorySearchKeywords.removeRange(0, _categorySearchKeywords.length - 4);
        }
        _categorySearchKeywords.add(searchKey);
        await appDataProvider.prefs!.setString("category_search_keywords", json.encode(_categorySearchKeywords));
      }

      _searchPageState = _searchPageState.update(
        progressState: 2,
        categoryList: categoryList,
      );

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
