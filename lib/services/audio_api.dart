import 'dart:convert';

import 'package:assignment_app/constants/strings.dart';
import 'package:assignment_app/models/audio_model.dart';
import 'package:http/http.dart' as http;

class AudioApi{
  Future<AudioModel> getAudio() async {
    var client = http.Client();
    var audioModel;

    try {
      var response = await client.get(Uri.parse(Strings.audio_url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        audioModel = AudioModel.fromJson(jsonMap);
        
      }
    } catch (Exception) {
      return audioModel;
    }
    return audioModel;
  }
}