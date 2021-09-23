import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:trapp/config/config.dart';
import 'package:trapp/environment.dart';
import 'package:trapp/src/dialogs/index.dart';
import 'package:trapp/src/models/index.dart';
import 'package:trapp/src/pages/AnnouncementDetailPage/index.dart';
import 'package:trapp/src/pages/CouponDetailPage/index.dart';
import 'package:trapp/src/pages/ProductItemDetailPage/index.dart';
import 'package:trapp/src/pages/StoreJobPostingDetailPage/index.dart';
import 'package:trapp/src/pages/StorePage/store_page.dart';
import 'package:trapp/src/pages/signup.dart';
import 'package:trapp/src/providers/index.dart';

class DynamicLinkService {
  static Future<Uri> createStoreDynamicLink(StoreModel? storeModel) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: Environment.dynamicLinkBase,
      link: Uri.parse('${Environment.dynamicLinkBase}.com/store?id=${storeModel!.id}'),
      androidParameters: AndroidParameters(
        packageName: 'com.tradilligence.TradeMantri',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.tradilligence.TradeMantri',
        minimumVersion: '1',
        appStoreId: 'your_app_store_id',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        imageUrl: Uri.parse(storeModel.profile!["image"] ?? ""),
        title: storeModel.name,
        description: storeModel.description,
      ),
      navigationInfoParameters: NavigationInfoParameters(forcedRedirectEnabled: true),
    );
    var dynamicUrl = await parameters.buildUrl();
    final shortenedLink = await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );
    return shortenedLink.shortUrl;
  }

  static Future<Uri> createProductDynamicLink({
    @required Map<String, dynamic>? itemData,
    @required StoreModel? storeModel,
    @required String? type,
    @required bool? isForCart,
  }) async {
    if (storeModel!.id == null || storeModel.id == "") {
      print("=======");
    }
    String url = '${Environment.dynamicLinkBase}.com/product_item';
    url += '?storeId=${storeModel.id}';
    url += '&itemId=${itemData!["_id"]}';
    url += '&type=$type';
    url += '&isForCart=$isForCart';

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: '${Environment.dynamicLinkBase}',
      link: Uri.parse(url),
      androidParameters: AndroidParameters(
        packageName: 'com.tradilligence.TradeMantri',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.tradilligence.TradeMantri',
        minimumVersion: '1',
        appStoreId: 'your_app_store_id',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        imageUrl: itemData["images"] != null && itemData["images"].isNotEmpty ? Uri.parse(itemData["images"][0]) : null,
        title: itemData["name"],
        description: "Store Name: ${storeModel.name}",
      ),
      navigationInfoParameters: NavigationInfoParameters(forcedRedirectEnabled: true),
    );
    var dynamicUrl = await parameters.buildUrl();
    final shortenedLink = await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );
    return shortenedLink.shortUrl;
  }

  static Future<Uri> createReferFriendLink({
    @required String? description,
    @required String? referralCode,
    @required String? referredByUserId,
    @required String? appliedFor,
  }) async {
    String url = '${Environment.dynamicLinkBase}.com/refer_friend';
    url += '?referralCode=$referralCode';
    url += '&referredByUserId=$referredByUserId';
    url += '&appliedFor=$appliedFor';

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: '${Environment.dynamicLinkBase}',
      link: Uri.parse(url),
      androidParameters: AndroidParameters(
        packageName: 'com.tradilligence.TradeMantri',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.tradilligence.TradeMantri',
        minimumVersion: '1',
        appStoreId: 'your_app_store_id',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: "Join TradeMantri and earn reward points",
        description:
            description! + "\nDownload the TradeMantri app now and order from 1000s of local stores and service providers. Support local businesses.",
      ),
      navigationInfoParameters: NavigationInfoParameters(forcedRedirectEnabled: true),
    );
    var dynamicUrl = await parameters.buildUrl();
    final shortenedLink = await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );
    return shortenedLink.shortUrl;
  }

  static Future<Uri> createReferStoreLink({
    @required String? description,
    @required String? referredBy,
    @required String? referredByUserId,
    @required String? appliedFor,
  }) async {
    String url = '${Environment.dynamicLinkBase}.com/refer_store';
    url += '?referredBy=$referredBy';
    url += '&referredByUserId=$referredByUserId';
    url += '&appliedFor=$appliedFor';

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: '${Environment.dynamicLinkBase}',
      link: Uri.parse(url),
      androidParameters: AndroidParameters(
        packageName: 'com.tradilligence.tradeMantriBiz',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.tradilligence.tradeMantriBiz',
        minimumVersion: '1',
        appStoreId: 'your_app_store_id',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: "Join TradeMantri and increase your sales",
        description: description! +
            "\nTradeMantri helps increase the reach of your business to wider audience and helps you grow your business in multiple ways.",
      ),
      navigationInfoParameters: NavigationInfoParameters(forcedRedirectEnabled: true),
    );
    var dynamicUrl = await parameters.buildUrl();
    final shortenedLink = await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );
    return shortenedLink.shortUrl;
  }

  static Future<Uri> createCouponDynamicLink({
    @required CouponModel? couponModel,
    @required StoreModel? storeModel,
  }) async {
    String url = '${Environment.dynamicLinkBase}.com/coupon';
    url += '?storeId=${storeModel!.id}';
    url += '&couponId=${couponModel!.id}';

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: '${Environment.dynamicLinkBase}',
      link: Uri.parse(url),
      androidParameters: AndroidParameters(
        packageName: 'com.tradilligence.TradeMantri',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.tradilligence.TradeMantri',
        minimumVersion: '1',
        appStoreId: 'your_app_store_id',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        imageUrl: Uri.parse(couponModel.images!.isNotEmpty ? couponModel.images![0] : AppConfig.discountTypeImages[couponModel.discountType]),
        title: couponModel.discountCode,
        description: "Store Name: ${storeModel.name}",
      ),
      navigationInfoParameters: NavigationInfoParameters(forcedRedirectEnabled: true),
    );
    var dynamicUrl = await parameters.buildUrl();
    final shortenedLink = await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );
    return shortenedLink.shortUrl;
  }

  static Future<Uri> createAnnouncementDynamicLink({
    @required Map<String, dynamic>? announcementData,
    @required Map<String, dynamic>? storeData,
  }) async {
    String url = '${Environment.dynamicLinkBase}.com/announcement';
    url += '?storeId=${storeData!["_id"]}';
    url += '&announcementId=${announcementData!["_id"]}';

    print(announcementData["images"].isNotEmpty ? announcementData["images"][0] : AppConfig.announcementImage[0]);

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: '${Environment.dynamicLinkBase}',
      link: Uri.parse(url),
      androidParameters: AndroidParameters(
        packageName: 'com.tradilligence.TradeMantri',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.tradilligence.TradeMantri',
        minimumVersion: '1',
        appStoreId: 'your_app_store_id',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        imageUrl: Uri.parse(announcementData["images"].isNotEmpty ? announcementData["images"][0] : AppConfig.announcementImage[0]),
        title: announcementData["title"],
        description: "Store Name: ${storeData["name"]}",
      ),
      navigationInfoParameters: NavigationInfoParameters(forcedRedirectEnabled: true),
    );
    var dynamicUrl = await parameters.buildUrl();
    final shortenedLink = await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );
    return shortenedLink.shortUrl;
  }

  static Future<Uri> createJobDynamicLink({
    @required Map<String, dynamic>? jobData,
    @required Map<String, dynamic>? storeData,
  }) async {
    String url = '${Environment.dynamicLinkBase}.com/job';
    url += '?storeId=${storeData!["_id"]}';
    url += '&jobId=${jobData!["_id"]}';

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: '${Environment.dynamicLinkBase}',
      link: Uri.parse(url),
      androidParameters: AndroidParameters(
        packageName: 'com.tradilligence.TradeMantri',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.tradilligence.TradeMantri',
        minimumVersion: '1',
        appStoreId: 'your_app_store_id',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: jobData["jobTitle"],
        description: "Store Name: ${storeData["name"]}",
      ),
      navigationInfoParameters: NavigationInfoParameters(forcedRedirectEnabled: true),
    );
    var dynamicUrl = await parameters.buildUrl();
    final shortenedLink = await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );
    return shortenedLink.shortUrl;
  }

  Future<void> retrieveDynamicLink(BuildContext context) async {
    try {
      FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          print("=================== FirebaseDynamicLinks.instance.onLink ======================");
          _dynamicLinkHandler(context, dynamicLink);
        },
        onError: (error) async {
          print(error.code);
          print(error.message);
          print(error.details);
        },
      );
    } catch (e) {
      print(e.toString());
    }

    final PendingDynamicLinkData? dynamicLink = await FirebaseDynamicLinks.instance.getInitialLink();
    print("=================== getInitialLink ======================");

    _dynamicLinkHandler(context, dynamicLink);
  }

  Future<void> _dynamicLinkHandler(BuildContext? context, PendingDynamicLinkData? dynamicLink) async {
    if (dynamicLink == null) return;
    final Uri deepLink = dynamicLink.link;
    print("=================== deepLink ======================");
    print(deepLink);
    print("===================================================");

    dynamic params = dynamicLink.link.queryParameters;
    switch (dynamicLink.link.pathSegments[0]) {
      case "store":
        Navigator.of(context!).push(
          MaterialPageRoute(
            builder: (context) => StorePage(storeId: params["id"]),
          ),
        );

        break;
      case "product_item":
        Navigator.of(context!).push(
          MaterialPageRoute(
            builder: (context) => ProductItemDetailPage(
              storeId: params["storeId"],
              itemId: params["itemId"],
              type: params["type"],
              isForCart: params["isForCart"].toString() == "true",
            ),
          ),
        );

        break;
      case "refer_friend":
        Navigator.of(context!).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => SignUpWidget(
              referralCode: params["referralCode"],
              referredByUserId: params["referredByUserId"],
              appliedFor: params["appliedFor"],
            ),
          ),
          (route) => false,
        );
        break;
      case "coupon":
        Navigator.of(context!).push(
          MaterialPageRoute(
            builder: (BuildContext context) => CouponDetailPage(
              couponId: params["couponId"],
              storeId: params["storeId"],
              storeModel: null,
            ),
          ),
        );
        break;

      case "job":
        Navigator.of(context!).push(
          MaterialPageRoute(
            builder: (BuildContext context) => StoreJobPostingDetailPage(
              jobId: params["jobId"],
              storeId: params["storeId"],
              jobPostingData: null,
            ),
          ),
        );
        break;

      case "announcement":
        Navigator.of(context!).push(
          MaterialPageRoute(
            builder: (BuildContext context) => AnnouncementDetailPage(
              announcementId: params["announcementId"],
              storeId: params["storeId"],
              announcementData: null,
              storeData: null,
            ),
          ),
        );
        break;

      default:
    }
  }
}
