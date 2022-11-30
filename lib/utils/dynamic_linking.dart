import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'dart:convert';
import 'package:share_plus/share_plus.dart';


class DynamicLinkService {

  static Future handleDynamicLinks() async {
    // 1. Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();

    // 2. handle link that has been retrieved
    // _handleDeepLink(data!);

    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      print("handle:");
      print(event.link.path);
      print(event.link.queryParameters);
      var argumentsEService = json.decode(event.link.queryParameters["data"].toString()) as Map<String, dynamic>;

/*
      Get.toNamed(Routes.E_SERVICE, arguments: {'eService': EService.fromJson(argumentsEService),
        'heroTag': event.link.queryParameters["heroTag"]});
*/

    }).onError((error){
      print(error);
    });
  }

  static Future<String> createFirstPostLink(String title,String image,{bool isShort=true}) async {
    String uriPrefix = "https://spareboxxes.page.link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: uriPrefix,
      link: Uri.parse('https://spareboxxes.page.link/post?data=$title'),
      androidParameters: const AndroidParameters(
        packageName: 'com.spareboxx.app',
        minimumVersion: 0,
      ),
      // NOT ALL ARE REQUIRED ===== HERE AS AN EXAMPLE =====
      // iosParameters: const IOSParameters (
      //   bundleId: 'com.spareboxx.app',
      //   minimumVersion: '0',
      //   appStoreId: '123456789',
      // ),
      googleAnalyticsParameters: const GoogleAnalyticsParameters(
        campaign: 'example-promo',
        medium: 'social',
        source: 'orkut',
      ),
      socialMetaTagParameters:  SocialMetaTagParameters(
        title: "Spare Boxx",
        imageUrl: Uri.parse(image),
        // description: "",
      ),
      // itunesConnectAnalyticsParameters: const ITunesConnectAnalyticsParameters(
      //   providerToken: '123456',
      //   campaignToken:'example-promo',
      // )
    );

    Uri dynamicUrl;
    if(isShort){
      final ShortDynamicLink shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
      dynamicUrl=shortDynamicLink.shortUrl;
    }
    else{
      dynamicUrl= await FirebaseDynamicLinks.instance.buildLink(parameters);
    }
    await Share.share(dynamicUrl.toString());
    return dynamicUrl.toString();
  }
}
