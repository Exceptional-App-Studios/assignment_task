import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TaskFour extends StatefulWidget {
  static const routeName = 'task-4';
  @override
  _TaskFourState createState() => _TaskFourState();
}

class _TaskFourState extends State<TaskFour> {
  AudioPlayer audioPlayer = new AudioPlayer();
  AudioCache audioCache;
  bool play = false;
  String url =
      "https://firebasestorage.googleapis.com/v0/b/mystical-glass-250612.appspot.com/o/shiv.mp3?alt=media&token=0d8aab6a-e77a-4978-a0fd-45023a8d6454";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);
  }

  @override
  Widget build(BuildContext context) {
    //Task 4: Playing Local Audio and Download Audio.
    //Hint: You can use audioplayer packages provided by flutter.
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: play ? Stopaudio : null,
            child: Container(
              height: 150,
              width: 150,
              color: play ? Colors.red : Colors.red[100],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 25, right: 25),
            child: Text(
              "Tap here to Stop audio",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 75),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 219,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    elevation: 10,
                    primary: Colors.green,
                  ),
                  onPressed: playurl,
                  child: Text(
                    'Download & Play',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 219,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    elevation: 10,
                    primary: HexColor('#363636'),
                  ),
                  onPressed: playlocal,
                  child: Text(
                    'Play local audio',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void playurl() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Download Started"),
    ));
    var res = await audioPlayer.play(url, isLocal: true);
    print(res);
    if (res == 1) {
      setState(() {
        play = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Audio is playing"),
      ));
    }
  }

  void playlocal() async {
    var res = await audioCache.play("mahadevpujari.mp3");

    setState(() {
      play = true;
    });
  }

  void Stopaudio() async {
    var res = await audioPlayer.stop();
    setState(() {
      play = false;
    });
  }
}
