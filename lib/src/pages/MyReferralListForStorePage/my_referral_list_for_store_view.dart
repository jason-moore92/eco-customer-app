import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trapp/config/config.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trapp/src/elements/keicy_text_form_field.dart';
import 'package:trapp/src/elements/store_reward_point_widget.dart';
import 'package:trapp/src/providers/index.dart';

import 'index.dart';

class MyReferralListForStoreView extends StatefulWidget {
  MyReferralListForStoreView({Key? key}) : super(key: key);

  @override
  _MyReferralListForStoreViewState createState() => _MyReferralListForStoreViewState();
}

class _MyReferralListForStoreViewState extends State<MyReferralListForStoreView> with SingleTickerProviderStateMixin {
  /// Responsive design variables
  double deviceWidth = 0;
  double deviceHeight = 0;
  double statusbarHeight = 0;
  double bottomBarHeight = 0;
  double appbarHeight = 0;
  double widthDp = 0;
  double heightDp = 0;
  double fontSp = 0;
  ///////////////////////////////

  AuthProvider? _authProvider;
  ReferralRewardOffersForStoreProvider? _referralRewardOffersForStoreProvider;
  RefreshController? _refreshController;

  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  String status = "ALL";

  @override
  void initState() {
    super.initState();

    /// Responsive design variables
    deviceWidth = 1.sw;
    deviceHeight = 1.sh;
    statusbarHeight = ScreenUtil().statusBarHeight;
    bottomBarHeight = ScreenUtil().bottomBarHeight;
    appbarHeight = AppBar().preferredSize.height;
    widthDp = ScreenUtil().setWidth(1);
    heightDp = ScreenUtil().setWidth(1);
    fontSp = ScreenUtil().setSp(1) / ScreenUtil().textScaleFactor;
    ///////////////////////////////

    _referralRewardOffersForStoreProvider = ReferralRewardOffersForStoreProvider.of(context);
    _authProvider = AuthProvider.of(context);
    _refreshController = RefreshController(initialRefresh: false);

    // _referralRewardOffersForStoreProvider!.setReferralRewardOffersForStoreState(
    //   _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.update(
    //     progressState: 0,
    //     referralRewardOffersForStoreListData: Map<String, dynamic>(),
    //     referralRewardOffersForStoreMetaData: Map<String, dynamic>(),
    //   ),
    //   isNotifiable: false,
    // );

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      _referralRewardOffersForStoreProvider!.addListener(_referralRewardOffersForStoreProviderListener);

      if (_referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.progressState == 0) {
        _referralRewardOffersForStoreProvider!.setReferralRewardOffersForStoreState(
          _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.update(progressState: 1),
        );
        _referralRewardOffersForStoreProvider!.getReferralRewardOffersForStoreData(
          referredByUserId: _authProvider!.authState.userModel!.id,
        );
      }
    });
  }

  @override
  void dispose() {
    _referralRewardOffersForStoreProvider!.removeListener(_referralRewardOffersForStoreProviderListener);

    super.dispose();
  }

  void _referralRewardOffersForStoreProviderListener() async {
    if (_referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.progressState == -1) {
      if (_referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.isRefresh!) {
        _referralRewardOffersForStoreProvider!.setReferralRewardOffersForStoreState(
          _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.update(isRefresh: false),
          isNotifiable: false,
        );
        _refreshController!.refreshFailed();
      } else {
        _refreshController!.loadFailed();
      }
    } else if (_referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.progressState == 2) {
      if (_referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.isRefresh!) {
        _referralRewardOffersForStoreProvider!.setReferralRewardOffersForStoreState(
          _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.update(isRefresh: false),
          isNotifiable: false,
        );
        _refreshController!.refreshCompleted();
      } else {
        _refreshController!.loadComplete();
      }
    }
  }

  void _onRefresh() async {
    Map<String, dynamic> referralRewardOffersForStoreListData =
        _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.referralRewardOffersForStoreListData!;
    Map<String, dynamic> referralRewardOffersForStoreMetaData =
        _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.referralRewardOffersForStoreMetaData!;

    referralRewardOffersForStoreListData[status] = [];
    referralRewardOffersForStoreMetaData[status] = Map<String, dynamic>();
    _referralRewardOffersForStoreProvider!.setReferralRewardOffersForStoreState(
      _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.update(
        progressState: 1,
        referralRewardOffersForStoreListData: referralRewardOffersForStoreListData,
        referralRewardOffersForStoreMetaData: referralRewardOffersForStoreMetaData,
        isRefresh: true,
      ),
    );

    _referralRewardOffersForStoreProvider!.getReferralRewardOffersForStoreData(
      referredByUserId: _authProvider!.authState.userModel!.id,
      searchKey: _controller.text.trim(),
    );
  }

  void _onLoading() async {
    _referralRewardOffersForStoreProvider!.setReferralRewardOffersForStoreState(
      _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.update(progressState: 1),
    );
    _referralRewardOffersForStoreProvider!.getReferralRewardOffersForStoreData(
      referredByUserId: _authProvider!.authState.userModel!.id,
      searchKey: _controller.text.trim(),
    );
  }

  void _searchKeyMyReferralListForStoreHandler() {
    Map<String, dynamic> referralRewardOffersForStoreListData =
        _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.referralRewardOffersForStoreListData!;
    Map<String, dynamic> referralRewardOffersForStoreMetaData =
        _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.referralRewardOffersForStoreMetaData!;

    referralRewardOffersForStoreListData[status] = [];
    referralRewardOffersForStoreMetaData[status] = Map<String, dynamic>();
    _referralRewardOffersForStoreProvider!.setReferralRewardOffersForStoreState(
      _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.update(
        progressState: 1,
        referralRewardOffersForStoreListData: referralRewardOffersForStoreListData,
        referralRewardOffersForStoreMetaData: referralRewardOffersForStoreMetaData,
      ),
    );

    _referralRewardOffersForStoreProvider!.getReferralRewardOffersForStoreData(
      referredByUserId: _authProvider!.authState.userModel!.id,
      searchKey: _controller.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Store Referrals",
          style: TextStyle(fontSize: fontSp * 20, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Consumer<ReferralRewardOffersForStoreProvider>(builder: (context, referralRewardOffersForStoreProvider, _) {
        if (referralRewardOffersForStoreProvider.referralRewardOffersForStoreState.progressState == 0) {
          return Center(child: CupertinoActivityIndicator());
        }
        return Container(
          width: deviceWidth,
          height: deviceHeight,
          child: Column(
            children: [
              _searchField(),
              Expanded(child: _myReferralListForStorePanel()),
            ],
          ),
        );
      }),
    );
  }

  Widget _searchField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widthDp * 20),
      child: KeicyTextFormField(
        controller: _controller,
        focusNode: _focusNode,
        width: null,
        height: heightDp * 50,
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        errorBorder: Border.all(color: Colors.grey.withOpacity(0.3)),
        borderRadius: heightDp * 6,
        contentHorizontalPadding: widthDp * 10,
        textStyle: TextStyle(fontSize: fontSp * 14, color: Colors.black),
        hintStyle: TextStyle(fontSize: fontSp * 14, color: Colors.grey.withOpacity(0.6)),
        hintText: MyReferralListForStorePageString.searchHint,
        prefixIcons: [Icon(Icons.search, size: heightDp * 20, color: Colors.grey.withOpacity(0.6))],
        suffixIcons: [
          GestureDetector(
            onTap: () {
              _controller.clear();
              FocusScope.of(context).requestFocus(FocusNode());
              _searchKeyMyReferralListForStoreHandler();
            },
            child: Icon(Icons.close, size: heightDp * 20, color: Colors.grey.withOpacity(0.6)),
          ),
        ],
        onFieldSubmittedHandler: (input) {
          FocusScope.of(context).requestFocus(FocusNode());
          _searchKeyMyReferralListForStoreHandler();
        },
      ),
    );
  }

  Widget _myReferralListForStorePanel() {
    List<dynamic> myReferralListForStore = [];
    Map<String, dynamic> referralRewardOffersForStoreMetaData = Map<String, dynamic>();

    if (_referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.referralRewardOffersForStoreListData![status] != null) {
      myReferralListForStore = _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.referralRewardOffersForStoreListData![status];
    }
    if (_referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.referralRewardOffersForStoreMetaData![status] != null) {
      referralRewardOffersForStoreMetaData =
          _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.referralRewardOffersForStoreMetaData![status];
    }

    int itemCount = 0;

    if (_referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.referralRewardOffersForStoreListData![status] != null) {
      List<dynamic> data = _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.referralRewardOffersForStoreListData![status];
      itemCount += data.length;
    }

    if (_referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.progressState == 1) {
      itemCount += AppConfig.countLimitForList;
    }

    return Column(
      children: [
        Expanded(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowGlow();
              return true;
            },
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: (referralRewardOffersForStoreMetaData["nextPage"] != null &&
                  _referralRewardOffersForStoreProvider!.referralRewardOffersForStoreState.progressState != 1),
              header: WaterDropHeader(),
              footer: ClassicFooter(),
              controller: _refreshController!,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: itemCount == 0
                  ? Center(
                      child: Text(
                        "No Store Review Available",
                        style: TextStyle(fontSize: fontSp * 14, color: Colors.black),
                      ),
                    )
                  : ListView.builder(
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> referralRewardData =
                            (index >= myReferralListForStore.length) ? Map<String, dynamic>() : myReferralListForStore[index];

                        return StoreRewardPointWidget(
                          referralRewardData: referralRewardData,
                          isLoading: referralRewardData.isEmpty,
                        );
                      },
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
