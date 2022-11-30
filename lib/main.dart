import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sparebboxx/utils/dynamic_linking.dart';
import 'package:sparebboxx/utils/routes.dart';
import 'package:sparebboxx/utils/theme.dart';
import 'binding/binding.dart';
import 'hive_storage/mobile_storage.dart';
import 'utils/theme_mode.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

Box? box;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Hive.initFlutter();
  Hive.registerAdapter(MobileStorageAdapter());
  box = await Hive.openBox("box");
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  MobileStorage? mobileStorage= box?.get("userData");

  @override
  Widget build(BuildContext context) {
    DynamicLinkService.handleDynamicLinks();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) =>
            GetMaterialApp(
              debugShowCheckedModeBanner: false,
              debugShowMaterialGrid: false,
              title: 'Spare Boxx',
              defaultTransition: Transition.rightToLeft,
              theme: MyTheme.lightTheme(context),
              darkTheme: MyTheme.darkTheme(context),
              themeMode: ThemeService().theme,
              initialBinding: DataBinding(),
              initialRoute: mobileStorage?.token == null ? Routes
                  .onBoardingScreen : Routes.bottomNavBarScreen,
              getPages: Routes.routes,
            )
    );
  }
}


