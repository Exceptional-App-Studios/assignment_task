import 'dart:convert';

AudioModel audioModelFromJson(String str) => AudioModel.fromJson(json.decode(str));

String audioModelToJson(AudioModel data) => json.encode(data.toJson());

class AudioModel {
    AudioModel({
        this.audioFile,
    });

    String audioFile;

    factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
        audioFile: json["audio_file"],
    );

    Map<String, dynamic> toJson() => {
        "audio_file": audioFile,
    };
}
