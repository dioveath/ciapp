import 'package:ciapp/loading_wrapper.dart';
import 'package:ciapp/service/ad_service.dart';
import 'package:ciapp/service/authentication_service.dart';
import 'package:ciapp/theme_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ciapp/routes.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adService = AdService(initFuture);

  await Firebase.initializeApp();
  runApp(Provider.value(value: adService, child: MyApp()));
  // child: DevicePreview(enabled: true, builder: (context) => MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Charicha Institute',
        theme: theme(),
        home: LoadingWrapper(),
        routes: routes,
      ),
    );
  }
}
