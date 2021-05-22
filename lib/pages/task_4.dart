import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';

class TaskFour extends StatefulWidget {
  static const routeName = 'task-4';
  @override
  _TaskFourState createState() => _TaskFourState();
}

class _TaskFourState extends State<TaskFour> {
  AudioPlayer player = AudioPlayer();
  static AudioCache audioCache = AudioCache();

  bool isPlaying = false;
  bool isStopped = false;
  String path = 'playMusic.mp3';

  Map mapResponse = Map();
  String song = '';

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.https(
        'exceptional-studios.herokuapp.com','api/audio-task'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        song = mapResponse['audio_file'];
      });
    } else {
      song = '';
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void playHandler() async {

    player = await audioCache.play('playMusic.mp3');

    setState(() {
      isPlaying = true;
    });
  }

  void stopPlay() {
    player.stop();
    setState(() {
      isPlaying = false;
    });
  }

  initAudio() {
    player.play(mapResponse['audio_file'].toString());
  }

  pauseAudio() {
    player.pause();
  }

  stopAudio() {
    player.stop();
  }

  @override
  Widget build(BuildContext context) {
    //Task 4: Playing Local Audio and Download Audio.
    //Hint: You can use audioplayer packages provided by flutter.
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20.0),
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.width / 2.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: HexColor('#DC143C'),
                  ),
                  onPressed: () {
                    stopAudio();
                    stopPlay();
                  },
                  child: Text(
                    'Stop',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              Text('Tap here to stop audio.'),
              SizedBox(
                height: MediaQuery.of(context).size.height/5,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20.0),
                width: MediaQuery.of(context).size.width / 2,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    elevation: 10,
                    primary: HexColor('#006400'),
                  ),
                  onPressed: () async {
                    final status = await Permission.storage.request();

                    if (status.isGranted) {
                      initAudio();
                      final externalDir = await getExternalStorageDirectories();
                      FlutterDownloader.enqueue(
                        url: mapResponse['audio_file'],
                        savedDir: externalDir.toString(),
                        fileName: 'Song',
                        showNotification: true,
                        openFileFromNotification: true,
                      );
                      showInSnackBar('Download started.');

                    }
                  },
                  child: Text(
                    'Download and play',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20.0),
                width: MediaQuery.of(context).size.width / 2,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    elevation: 10,
                    primary: HexColor('#363636'),
                  ),
                  onPressed: playHandler,
                  child: Text(
                    'Play from assets',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: Text(value),
      ),
    );
  }
}
