import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class TaskFour extends StatefulWidget {
  static const routeName = 'task-4';
  @override
  _TaskFourState createState() => _TaskFourState();
}

class _TaskFourState extends State<TaskFour> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache= AudioCache();
  bool isPlaying=false;

  void fetchAudio()async{
    try{
      var response = await http.get(Uri.https("exceptional-studios.herokuapp.com", "api/audio-task"));
      if(response.statusCode == 200){
        var ans =  jsonDecode(response.body);
        _downloadFile(ans['audio_file']);
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Downloading audio...'),
          ),
      );

    }
    catch(e){
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error occurred while downloading!'),
          ),
      );
    }
  }


  void _downloadFile(String url) async{
    var fileP=await DefaultCacheManager().downloadFile(url);
    playSong(fileP.file.path,true);
  }

  playSong(String path,local) async{
    audioPlayer.stop();
    if(local){
      audioPlayer.play(path, isLocal: local);
      setState(() {
        isPlaying=true;
      });
    }
    else{
      audioPlayer= await audioCache.play(path);
      setState(() {
        isPlaying=true;
      });
    }

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        isPlaying=false;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    //Task 4: Playing Local Audio and Download Audio.
    //Hint: You can use audioplayer packages provided by flutter.
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Spacer(),
                Container(
                  width: 150,
                  height: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: isPlaying
                      ?(){audioPlayer.stop();setState(() {isPlaying=false;});}
                      :null,
                    child: Text("Pause"),
                  ),
                ),
                SizedBox(height: 20,),
                Text("Tap here to stop audio."),
                Spacer(),
                Container(
                  width: 219,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 10,
                      primary: Colors.green[700],
                    ),
                    onPressed: ()  {
                      fetchAudio();
                    },
                    child: Text(
                      'Download & Play',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 219,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 10,
                      primary: Colors.black,
                    ),
                    onPressed: ()  async{
                      print("hi");
                      playSong("song.mp3", false);
                    },
                    child: Text(
                      'Play local audio',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
