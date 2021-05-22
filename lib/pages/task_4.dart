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
  AudioCache audioCache = new AudioCache();
  bool play = false;
  String url =
      "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3";

  @override
  Widget build(BuildContext context) {
    //Task 4: Playing Local Audio and Download Audio.
    //Hint: You can use audioplayer packages provided by flutter.
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: play ? stopaudio : null,
            child: Container(
              height: 100,
              width: 100,
              color: play ? Colors.green : Colors.red,
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
                width: 250,
                height: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    elevation: 10,
                    primary: Colors.green,
                  ),
                  onPressed: urlPlay,
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
                width: 250,
                height: 70,
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

  void urlPlay() async {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Playing Remote Audio"),
      ));
    var res = await audioPlayer.play(url, isLocal: true);
    print(res);
    if (res == 1) {
      setState(() {
        play = true;
      });
    
    }
  }

  void playlocal() async {
    audioPlayer = await audioCache.play('music.mp3');
    setState(() {
      play = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Playing Local Audio"),
    ));
  }

  void stopaudio() async {
    await audioPlayer.stop();

    setState(() {
      play = false;
    });
  }
}
