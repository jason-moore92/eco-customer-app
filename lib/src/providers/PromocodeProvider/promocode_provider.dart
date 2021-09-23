import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trapp/src/ApiDataProviders/index.dart';

import 'index.dart';

class PromocodeProvider extends ChangeNotifier {
  static PromocodeProvider of(BuildContext context, {bool listen = false}) => Provider.of<PromocodeProvider>(context, listen: listen);

  PromocodeState _promocodeState = PromocodeState.init();
  PromocodeState get promocodeState => _promocodeState;

  SharedPreferences? _prefs;
  SharedPreferences? get prefs => _prefs;

  void setPromocodeState(PromocodeState promocodeState, {bool isNotifiable = true}) {
    if (_promocodeState != promocodeState) {
      _promocodeState = promocodeState;
      if (isNotifiable) notifyListeners();
    }
  }

  Future<void> getPromocodeData({@required String? category}) async {
    if (category == null) {
      return;
    }
    Map<String, dynamic> promocodeData = json.decode(json.encode(_promocodeState.promocodeData));

    try {
      var result = await PromocodeApiProvider.getPromocodeData(category: category);
      if (result["success"]) {
        promocodeData[category] = result["data"];
        _promocodeState = _promocodeState.update(
          promocodeData: promocodeData,
          progressState: 2,
          message: "",
        );
      }
    } catch (e) {
      promocodeData[category] = [];
      _promocodeState = _promocodeState.update(
        promocodeData: promocodeData,
        progressState: 2,
        message: "",
      );
    }

    notifyListeners();
  }
}
