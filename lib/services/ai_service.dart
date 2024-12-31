import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:llama_flutter_integration/utils/constants.dart';

class AiService {
  static const platform = MethodChannel(aiAssistantChannel);

  Future<String> generateResponse(String prompt) async {
    try {
      final String response = await platform.invokeMethod('generateResponse', {
        'prompt': prompt,
      });
      return response;
    } on PlatformException catch (e) {
      return 'Error: ${e.message}';
    }
  }

  Future<bool> initModel() async {
    try {
      final bool success = await platform.invokeMethod('initModel');
      return success;
    } on PlatformException catch (e) {
      debugPrint('Error initializing model: ${e.message}');
      return false;
    }
  }
}
