import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trapp/src/ApiDataProviders/index.dart';

import 'index.dart';

class ReferralRewardOffersForStoreProvider extends ChangeNotifier {
  static ReferralRewardOffersForStoreProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<ReferralRewardOffersForStoreProvider>(context, listen: listen);

  ReferralRewardOffersForStoreState _referralRewardOffersForStoreState = ReferralRewardOffersForStoreState.init();
  ReferralRewardOffersForStoreState get referralRewardOffersForStoreState => _referralRewardOffersForStoreState;

  SharedPreferences? _prefs;
  SharedPreferences? get prefs => _prefs;

  void setReferralRewardOffersForStoreState(ReferralRewardOffersForStoreState referralRewardOffersForStoreState, {bool isNotifiable = true}) {
    if (_referralRewardOffersForStoreState != referralRewardOffersForStoreState) {
      _referralRewardOffersForStoreState = referralRewardOffersForStoreState;
      if (isNotifiable) notifyListeners();
    }
  }

  Future<void> getReferralRewardOffersForStoreData({@required String? referredByUserId, String searchKey = ""}) async {
    Map<String, dynamic> referralRewardOffersForStoreListData = _referralRewardOffersForStoreState.referralRewardOffersForStoreListData!;
    Map<String, dynamic> referralRewardOffersForStoreMetaData = _referralRewardOffersForStoreState.referralRewardOffersForStoreMetaData!;
    try {
      if (referralRewardOffersForStoreListData["ALL"] == null) referralRewardOffersForStoreListData["ALL"] = [];
      if (referralRewardOffersForStoreMetaData["ALL"] == null) referralRewardOffersForStoreMetaData["ALL"] = Map<String, dynamic>();

      var result;

      result = await ReferralRewardOffersForStoreApiProvider.getReferralRewardOffersData(
        referredByUserId: referredByUserId,
        searchKey: searchKey,
        page: referralRewardOffersForStoreMetaData["ALL"].isEmpty ? 1 : (referralRewardOffersForStoreMetaData["ALL"]["nextPage"] ?? 1),
        limit: AppConfig.countLimitForList,
        // limit: 1,
      );

      if (result["success"]) {
        for (var i = 0; i < result["data"]["docs"].length; i++) {
          referralRewardOffersForStoreListData["ALL"].add(result["data"]["docs"][i]);
        }
        result["data"].remove("docs");
        referralRewardOffersForStoreMetaData["ALL"] = result["data"];

        _referralRewardOffersForStoreState = _referralRewardOffersForStoreState.update(
          progressState: 2,
          referralRewardOffersForStoreListData: referralRewardOffersForStoreListData,
          referralRewardOffersForStoreMetaData: referralRewardOffersForStoreMetaData,
        );
      } else {
        _referralRewardOffersForStoreState = _referralRewardOffersForStoreState.update(
          progressState: 2,
        );
      }
    } catch (e) {
      _referralRewardOffersForStoreState = _referralRewardOffersForStoreState.update(
        progressState: 2,
      );
    }
    notifyListeners();
  }
}
