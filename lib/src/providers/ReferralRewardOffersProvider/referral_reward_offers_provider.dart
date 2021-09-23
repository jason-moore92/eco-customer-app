import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trapp/src/ApiDataProviders/index.dart';

import 'index.dart';

class ReferralRewardOffersProvider extends ChangeNotifier {
  static ReferralRewardOffersProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<ReferralRewardOffersProvider>(context, listen: listen);

  ReferralRewardOffersState _referralRewardOffersState = ReferralRewardOffersState.init();
  ReferralRewardOffersState get referralRewardOffersState => _referralRewardOffersState;

  SharedPreferences? _prefs;
  SharedPreferences? get prefs => _prefs;

  void setReferralRewardOffersState(ReferralRewardOffersState referralRewardOffersState, {bool isNotifiable = true}) {
    if (_referralRewardOffersState != referralRewardOffersState) {
      _referralRewardOffersState = referralRewardOffersState;
      if (isNotifiable) notifyListeners();
    }
  }

  Future<void> getReferralRewardOffersData({@required String? referredByUserId, String searchKey = ""}) async {
    Map<String, dynamic> referralRewardOffersListData = _referralRewardOffersState.referralRewardOffersListData!;
    Map<String, dynamic> referralRewardOffersMetaData = _referralRewardOffersState.referralRewardOffersMetaData!;
    try {
      if (referralRewardOffersListData["ALL"] == null) referralRewardOffersListData["ALL"] = [];
      if (referralRewardOffersMetaData["ALL"] == null) referralRewardOffersMetaData["ALL"] = Map<String, dynamic>();

      var result;

      result = await ReferralRewardOffersApiProvider.getReferralRewardOffersData(
        referredByUserId: referredByUserId,
        searchKey: searchKey,
        page: referralRewardOffersMetaData["ALL"].isEmpty ? 1 : (referralRewardOffersMetaData["ALL"]["nextPage"] ?? 1),
        limit: AppConfig.countLimitForList,
        // limit: 1,
      );

      if (result["success"]) {
        for (var i = 0; i < result["data"]["docs"].length; i++) {
          referralRewardOffersListData["ALL"].add(result["data"]["docs"][i]);
        }
        result["data"].remove("docs");
        referralRewardOffersMetaData["ALL"] = result["data"];

        _referralRewardOffersState = _referralRewardOffersState.update(
          progressState: 2,
          referralRewardOffersListData: referralRewardOffersListData,
          referralRewardOffersMetaData: referralRewardOffersMetaData,
        );
      } else {
        _referralRewardOffersState = _referralRewardOffersState.update(
          progressState: 2,
        );
      }
    } catch (e) {
      _referralRewardOffersState = _referralRewardOffersState.update(
        progressState: 2,
      );
    }
    notifyListeners();
  }
}
