import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:audioplayers/audioplayers.dart';

class TaskFour extends StatefulWidget {
  static const routeName = 'task-4';
  @override
  _TaskFourState createState() => _TaskFourState();
}

class _TaskFourState extends State<TaskFour> {
  String audiourl = "https://firebasestorage.googleapis.com/v0/b/fire-1ce9b.appspot.com/o/Badnam%20Gabru%20-%20Masoom%20Sharma%20320%20Kbps.mp3?alt=media&token=bde07be2-f4e7-4c0a-a8d3-fb3f76194b96";
  bool play = false;
  AudioPlayer audioPlayer = new  AudioPlayer();
  AudioCache audioCache;
  @override
  Widget build(BuildContext context) {
    //Task 4: Playing Local Audio and Download Audio.
    //Hint: You can use audioplayer packages provided by flutter.
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: play ? Stop : null,
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
                  onPressed: downloadandplay,
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
                  onPressed: Localplay,
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

  void downloadandplay() async{

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Downloading"))
    );

    var result = await audioPlayer.play(audiourl,isLocal: true);
    if(result == 1)
      {
        setState(() {
          play = true;
        });
      }

  }

  void Stop() async{

    var result = await audioPlayer.stop();

    setState(() {
      play = false;
    });

  }

  void Localplay() async{

    audioCache = new AudioCache(fixedPlayer: audioPlayer);

    var result = await audioCache.play("EXPERTJATT.mp3");

    setState(() {
      play = true;
    });

  }
}
