import 'dart:async';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:trapp/app.dart';
import 'package:trapp/environment.dart';
import 'package:trapp/src/providers/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseApp appy = Firebase.app();
  print("Using firebase project id: " + appy.options.projectId);

  await getFirebaseAnalytics().setAnalyticsCollectionEnabled(true);

  Freshchat.init(
    Environment.freshChatId!,
    Environment.freshChatKey!,
    Environment.freshChatDomain!,
    // teamMemberInfoVisible: true,
    cameraCaptureEnabled: true,
    // gallerySelectionEnabled: true,
    responseExpectationEnabled: true,
    userEventsTrackingEnabled: Environment.enableFreshChatEvents!,
  );

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  runZonedGuarded(() {
    runApp(
      EasyDynamicThemeWidget(
        child: Phoenix(
          child: MyApp(),
        ),
      ),
    );
  }, FirebaseCrashlytics.instance.recordError);

  // runApp(
  //   Phoenix(
  //     child: MyApp(),
  //   ),
  // );
}
