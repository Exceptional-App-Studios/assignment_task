import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TaskFour extends StatefulWidget {
  static const routeName = 'task-4';
  @override
  _TaskFourState createState() => _TaskFourState();
}

class _TaskFourState extends State<TaskFour> {
  String url = "https://exceptional-studios.herokuapp.com/api/audio-task";
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.PAUSED;
  AudioCache audioCache;
  String assetMusic = "song.mp3";
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer,prefix: "");

    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      setState(() {
        playerState = s;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearAll();
    super.dispose();
  }

  playMusic() async {
    isPlaying = true;
    await audioCache.play(assetMusic);
  }

  pauseMusic() async {
    isPlaying = false;
    await audioPlayer.pause();
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
                    onPressed: ()  {
                      pauseMusic();
                    },
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Download Started.")));
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
                      playMusic();
                      print("hi");
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
