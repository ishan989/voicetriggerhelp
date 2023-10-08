package com.example.call_module
import android.os.Bundle
import android.telephony.SmsManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
     private val callResult: MethodChannel.Result? = null
     fun onCreate(savedInstanceState: Bundle?, flutterEngine: FlutterEngine) {
         super.onCreate(savedInstanceState)
         GeneratedPluginRegistrant.registerWith(flutterEngine)
         MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
             if (call.method == "send") {
                 val num = call.argument<String>("phone")
                 val msg = call.argument<String>("msg")
                 sendSMS(num, msg, result)
             } else {
                 result.notImplemented()
             }
         }
     }

     private fun sendSMS(phoneNo: String?, msg: String?, result: MethodChannel.Result) {
         try {
             val smsManager = SmsManager.getDefault()
             smsManager.sendTextMessage(phoneNo, null, msg, null, null)
             result.success("SMS Sent")
         } catch (ex: Exception) {
             ex.printStackTrace()
             result.error("Err", "Sms Not Sent", "")
         }
     }

     companion object {
         private const val CHANNEL = "sendSms"
     }
}
