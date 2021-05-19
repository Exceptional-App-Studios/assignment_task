import 'package:assignment_app/models/audio_model.dart';
import 'package:assignment_app/services/audio_api.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:isolate';
import 'dart:ui';

typedef void OnError(Exception exception);

class TaskFour extends StatefulWidget {
  static const routeName = 'task-4';
  @override
  _TaskFourState createState() => _TaskFourState();
}

class _TaskFourState extends State<TaskFour> {

  AudioPlayer audioPlayer = new AudioPlayer();
  
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  bool playing = false;
  String localFilePath;
  int progress = 0;

  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort.send([id, status, progress]);
  }

  void initDownload() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
    );
    IsolateNameServer.registerPortWithName(_receivePort.sendPort, "downloading");


    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });


    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  void initState(){
    super.initState();
    initPlayer();
    initDownload();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Task 4: Playing Local Audio and Download Audio.
    //Hint: You can use audioplayer packages provided by flutter.
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(playing == true){
                        pauseAudio();
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height/5,
                      width: MediaQuery.of(context).size.width/2,
                      color: playing == false
                        ? Colors.red[200]
                        : Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Tap here to stop audio.",
                    style: TextStyle(
                      fontSize: 18,
                      color: playing == false
                        ? Colors.grey[400]
                        : Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 219,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        elevation: 10,
                        primary: Colors.green,
                      ),
                      onPressed: (){
                        getAudio();
                      },
                      // onPressed: () async => await audioCache.play('audio.mp3'),
                      child: Text(
                        'Download & Play',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 219,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        elevation: 10,
                        primary: HexColor('#363636'),
                      ),
                      onPressed: () {
                        getLocalAudio();
                      },
                      child: Text(
                        'Play local audio',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ]
          ),
        )
      ),
    );
  }

  void getAudio() async {
    // var url = 'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3';
    
    try{
    AudioModel audiomodel = await AudioApi().getAudio();
    var url = audiomodel.audioFile;
    // play audio
    var res = await audioPlayer.play(url);
    if(res == 1){
      setState(() {
        playing = true;
      });
      
    }

    final status = await Permission.storage.request();
    print(status);
    print("status");
    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      print("In .....");
      final id = await FlutterDownloader.enqueue(
        url: url,
        savedDir: externalDir.path,
        fileName: "download",
        showNotification: true,
        openFileFromNotification: true,
      );

      final snackBar = SnackBar(
        content: Text('Download $progress%'),
        action: SnackBarAction(
          label: '',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);


    } else {
      print("Permission deined");
    }
    } catch(Exception){
      print("Exception");
    }
  }

  void getLocalAudio() async {
    audioCache.play('audio.mp3');
    setState(() {
      playing = true;
    });
    print("audio cache");
  }

  void pauseAudio() async {

    var res = await audioPlayer.pause();
    if(res == 1){
      setState(() {
        playing = false;
      });
    }
    advancedPlayer.pause();
  }
}
