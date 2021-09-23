# trapp

A new Flutter project.

## Commands

1. Prod build cmd `flutter build appbundle --target lib/main_prod.dart --release --flavor prod`
2. Qa build cmd `flutter build appbundle --target lib/main_qa.dart --release --flavor qa`
3. Checking release in local `flutter run --target lib/main_prod.dart --flavor prod`.
4. Checking the GTM open app with `adb shell am start -a "android.intent.action.VIEW" -d "tagmanager.c.com.tradilligence.TradeMantri://preview/p?id=GTM-T8K34MQ\&gtm_auth=yA9NmGEJ1TlAKsm0w8W3Qw\&gtm_preview=1"` (Not using anyway)
5. for FA-svc: `adb shell setprop log.tag.FA-SVC VERBOSE` and `adb shell setprop log.tag.FA VERBOSE`


dynamic helper
###


https://play.google.com/store/apps/details?id=com.tradilligence.TradeMantri

https://www.woolha.com/tutorials/flutter-using-firebase-dynamic-links
