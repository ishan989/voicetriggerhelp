import 'package:call_module/background.dart';
import 'package:call_module/call.dart';
import 'package:call_module/comm.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final CallSmsModuleState cms =  CallSmsModuleState();
    final SpeechToText _speech = SpeechToText();
  bool isListening = false;
  String _recognizedText = '';

  @override
  void initState() {
    super.initState();
    _initSpeechRecognition();
    const backy();
  }

  void _initSpeechRecognition() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print(status);
        if (status == 'notListening') {
          setState(() {
            isListening = false;
          });
          _startListening(); // Feri sunnn
        }
      },
      onError: (errorNotification) {
        print('Error: $errorNotification');
      },
    );

    if (available) {
      _startListening(); // Start listening initially
    }
  }

  void _startListening() async {
    setState(() {
      isListening = true;
      _recognizedText = ''; // Clear previous recognized text
    });

    await _speech.listen(
      onResult: (result) {
        setState(() {
          _recognizedText =
              result.recognizedWords;
              String trytxt = _recognizedText.toLowerCase();
              String neededword = 'help';
              
              if(trytxt.contains(neededword)){
                cms.initiateCommunication();
              } // Accumulate recognized words
        });

        // if (_recognizedText.toLowerCase().contains("stop listening")) {
        //   // Handle the action when "stop listening" is detected
        //   setState(() {
        //     isListening = false; // Stop listening
        //   });
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Spoken Text',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              controller: TextEditingController(text: _recognizedText),
            ),
          ],
        ),
      ),
    );
  }
}