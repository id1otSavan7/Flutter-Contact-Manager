import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';

class MakeCall {
  Future<void> makePhoneCall(String? phoneNumber) async {
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }

    if (status.isGranted) {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber!);
    } else {
      throw Exception("Permission Denied!");
    }
  }

  Future<void> openMessage(String? phoneNumber) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    if(await canLaunchUrl(smsUri)){
      await launchUrl(smsUri);
    }
  }
}

