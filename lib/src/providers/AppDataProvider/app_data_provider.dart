import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trapp/config/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trapp/src/ApiDataProviders/index.dart';

import 'index.dart';

class AppDataProvider extends ChangeNotifier {
  static AppDataProvider of(BuildContext context, {bool listen = false}) => Provider.of<AppDataProvider>(context, listen: listen);

  AppDataState _appDataState = AppDataState.init();
  AppDataState get appDataState => _appDataState;

  SharedPreferences? _prefs;
  SharedPreferences? get prefs => _prefs;

  void setAppDataState(AppDataState appDataState, {bool isNotifiable = true}) {
    if (_appDataState != appDataState) {
      _appDataState = appDataState;
      if (isNotifiable) notifyListeners();
    }
  }

  void init() async {
    try {
      _prefs = await SharedPreferences.getInstance();

      int distance = prefs!.getInt("distance") == null ? AppConfig.distances[0]["value"] : prefs!.getInt("distance");
      List<dynamic> savedLocationList = prefs!.getString("saved_location_list") == null ? [] : json.decode(prefs!.getString("saved_location_list")!);
      List<dynamic> recentLocationList =
          prefs!.getString("recent_location_list") == null ? [] : json.decode(prefs!.getString("recent_location_list")!);

      _appDataState = _appDataState.update(
        distance: distance,
        savedLocationList: savedLocationList,
        recentLocationList: recentLocationList,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<Position?> getCurrentPosition() async {
    Position position;
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      position = await Geolocator.getCurrentPosition();
      return position;
    } else {
      return null;
    }
  }

  /// get store list
  Future<void> getCategoryList({
    @required int? distance,
    @required Map<String, dynamic>? currentLocation,
    String searchKey = "",
  }) async {
    List<dynamic> categoryList = await getCategoryListData(
      distance: distance!,
      currentLocation: currentLocation!,
      searchKey: searchKey,
    );

    if (categoryList.isNotEmpty) {
      _appDataState = _appDataState.update(
        categoryList: categoryList,
        currentLocation: currentLocation,
        progressState: 2,
      );
    } else {
      _appDataState = _appDataState.update(
        progressState: 2,
        currentLocation: currentLocation,
        categoryList: [],
      );
    }
    notifyListeners();
  }

  /// get store list
  Future<List<dynamic>> getCategoryListData({
    @required int? distance,
    @required Map<String, dynamic>? currentLocation,
    String searchKey = "",
  }) async {
    // List<dynamic> categoryDataList = prefs.getString("category_data") == null ? [] : json.decode(prefs.getString("category_data"));

    // /// if the categoryData which datetime,distance and location info are the same on local is exist,
    // if (categoryDataList.isNotEmpty) {
    //   for (var i = 0; i < categoryDataList.length; i++) {
    //     Map<String, dynamic> categoryData = categoryDataList[i];
    //     if (categoryData["distance"] == distance &&
    //         categoryData["location"].toString() == currentLocation.toString() &&
    //         categoryData["searchKey"] == searchKey) {
    //       if (categoryData["date"] == DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).millisecondsSinceEpoch) {
    //         return categoryData["categoryList"];
    //       } else {
    //         categoryDataList.removeAt(i);
    //         return categoryData["categoryList"];
    //       }
    //     }
    //   }
    // }

    try {
      var result = await CategoryApiProvider.getCategoryList(
        location: currentLocation!["location"],
        distance: distance,
        searchKey: searchKey,
      );
      if (result["success"]) {
        List<Map<String, dynamic>> categoryList = [];
        for (var i = 0; i < result["data"].length; i++) {
          if (result["data"][i]["category"].isEmpty) continue;
          Map<String, dynamic> categoryData = result["data"][i]["category"][0];
          categoryData["storeCount"] = result["data"][i]["storeCount"];
          categoryList.add(categoryData);
        }
        if (categoryList.isNotEmpty) {
          await _storeDistance(distance!);
          await _storeRecentLocationList(currentLocation: currentLocation);
        }

        // await _storeCategoryData({
        //   "date": DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).millisecondsSinceEpoch,
        //   "location": currentLocation,
        //   "distance": distance,
        //   "categoryList": categoryList,
        //   "searchKey": searchKey,
        // });
        return categoryList;
      } else {
        _appDataState = _appDataState.update(
          progressState: -1,
          message: result["message"],
        );
        return [];
      }
    } catch (e) {
      _appDataState = _appDataState.update(
        progressState: -1,
        message: e.toString(),
      );
      notifyListeners();
      return [];
    }
  }

  /// store current location Info and recent location list to the localstorage.
  Future<void> _storeRecentLocationList({@required Map<String, dynamic>? currentLocation}) async {
    try {
      List<dynamic> recentLocationList = prefs!.getString("recent_location_list") == null
          ? []
          : json.decode(
              prefs!.getString("recent_location_list")!,
            );

      var index = recentLocationList.indexWhere((location) => location["placeID"] == currentLocation!["placeID"]);
      if (index != -1) {
        recentLocationList.removeAt(index);
      }

      if (recentLocationList.length >= 10) {
        recentLocationList.removeRange(0, recentLocationList.length - 9);
      }
      recentLocationList.add(currentLocation);
      prefs!.setString("recent_location_list", json.encode(recentLocationList));

      _appDataState = _appDataState.update(
        recentLocationList: recentLocationList,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _storeDistance(int distance) async {
    await prefs!.setInt("distance", distance);
    _appDataState = _appDataState.update(
      distance: distance,
    );
  }

  Future<void> _storeCategoryData(Map<String, dynamic> categoryData) async {
    List<dynamic> categoryDataList = prefs!.getString("category_data") == null ? [] : json.decode(prefs!.getString("category_data")!);
    categoryDataList.add(categoryData);
    await prefs!.setString("category_data", json.encode(categoryDataList));
  }

  Future<void> saveSavedLocation({@required Map<String, dynamic>? currentLocation}) async {
    List<dynamic> savedLocationList = prefs!.getString("saved_location_list") == null
        ? []
        : json.decode(
            prefs!.getString("saved_location_list")!,
          );
    var index = savedLocationList.indexWhere((location) => location["placeID"] == currentLocation!["placeID"]);
    if (index != -1) {
      savedLocationList[index] = currentLocation;
    } else {
      savedLocationList.add(currentLocation);
    }
    prefs!.setString("saved_location_list", json.encode(savedLocationList));

    _appDataState = _appDataState.update(
      savedLocationList: savedLocationList,
    );
    notifyListeners();
  }
}
