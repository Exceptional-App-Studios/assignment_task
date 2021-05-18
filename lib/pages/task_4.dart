import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:audioplayers/audioplayers.dart';

class TaskFour extends StatefulWidget {
  static const routeName = 'task-four';
  @override
  _TaskFourState createState() => _TaskFourState();
}

/*
For this task I have used the packages: audioplayers and flutter_cache_manager. flutter_cache_manager is used to download
the audio in cache and audioplayers is used to play audio.
 */
class _TaskFourState extends State<TaskFour> {
   AudioPlayer audioPlayer = AudioPlayer();
   AudioCache audiocache= AudioCache();
   bool isPlaying=false;

  void getdata()async{
    try{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Downloading audio...'),duration: Duration(seconds: 1), ));
    var apiURL = Uri.parse('https://exceptional-studios.herokuapp.com/api/audio-task');
    var response = await http.get(
      apiURL
    );
    if(response.statusCode == 200){
     var ans =  jsonDecode(response.body);
      _downloadFile(ans['audio_file']);
    }
    }
    catch(e){
      print(e);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Some error occured!'),duration: Duration(seconds: 1), ));
    }
  }


  void _downloadFile(String url) async{
      var filep=await DefaultCacheManager().downloadFile(url);
      playaudio(filep.file.path,true);
  }

  playaudio(String path,islocal) async{
      audioPlayer.stop();
    if(islocal){
  audioPlayer.play(path, isLocal: islocal);
  setState(() {
    isPlaying=true;
  });
    }
    else{
      audioPlayer= await audiocache.play(path);
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal :30.0),
                child: AspectRatio(aspectRatio: 1,
                  child: ElevatedButton(
                    onPressed: isPlaying?(){audioPlayer.stop();setState(() {
    isPlaying=false;
  });}:null,
                    style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            primary: Colors.red,
                          ),
                    child: Text(''),
                    
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                'Tap here to stop audio',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 60.0,),
              Container(
                width: 219,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    elevation: 10,
                    primary: Colors.green
                  ),
                  onPressed: () => getdata(),
                  child: Text(
                    'Download & Play',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
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
                  onPressed:() => playaudio('audio/audio1.mp3',false),
                  child: Text(
                    'Play local audio',
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
}
