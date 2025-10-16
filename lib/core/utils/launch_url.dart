import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';



class CustomLaunchUrl {
  ///launchUrlWhatsapp
  static Future<void> launchUrlWhatsapp(
      {required numPhone,
      required String name,
     }) async {
    var url = "https://web.whatsapp.com/send?phone=+$numPhone&text=$name";

    try {

        await launchUrl(Uri.parse(url));
    } catch (e) {
      debugPrint(e.toString());
    }
  }



  ///launchUrlCall
  static Future<void> launchUrlCall(
      {required numPhone, String? messageSms}) async {
    var androidUrl = 'tel:$numPhone';
    var iosUrl = 'tel:$numPhone';
    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else if (Platform.isAndroid) {
        await launchUrl(Uri.parse(androidUrl));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


}
