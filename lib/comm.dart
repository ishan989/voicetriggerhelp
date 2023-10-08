import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'call.dart';

class CallSmsModule extends StatefulWidget {
  @override
  CallSmsModuleState createState() => CallSmsModuleState();
}

class CallSmsModuleState extends State<CallSmsModule> {
  final List<String> phoneNumbers = ['9860295069'];
  final String callPhoneNumber = '9843339957';

  Future<String> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return 'https://maps.google.com/maps?q=${position.latitude},${position.longitude}';
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        break;
      case PermissionStatus.denied:
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      default:
        break;
    }
  }

  Future<void> requestSmsPermission() async {
    final status = await Permission.sms.request();
    switch (status) {
      case PermissionStatus.granted:
        break;
      case PermissionStatus.denied:
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      default:
        break;
    }
  }

  void initiateCommunication() async {
    // Send messages to the list of phoneNumbers
    for (String phoneNumber in phoneNumbers) {
      await requestLocationPermission();
      await requestSmsPermission();

      String senderLocation = await getCurrentLocation();
      String message = 'Help Help Help from $senderLocation!';

      sendSMS(message: message, recipients: [phoneNumber], sendDirect: true);
    }

    // Make a call to the specified callPhoneNumber
    CallHelper.callPhoneNumber(callPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CallSmsModule'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: initiateCommunication,
              child: Text('PressForHelp'),
            ),
          ],
        ),
      ),
    );
  }
}