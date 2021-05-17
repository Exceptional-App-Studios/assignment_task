import 'package:assignment_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:assets_audio_player/assets_audio_player.dart';

class TaskFour extends StatefulWidget {
  static const routeName = 'task-4';
  @override
  _TaskFourState createState() => _TaskFourState();
}

class _TaskFourState extends State<TaskFour> {
  final assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  bool isLoading = false;
  bool isPlaying = false;
  get ss => setState(() {});

  @override
  void dispose() {
    super.dispose();
  }

  void playUrl() async {
    final songUrl = await ApiService().getSong();
    await assetsAudioPlayer.open(Audio.network(songUrl));
  }

  void playAsset() async {
    await assetsAudioPlayer.open(
      Audio(
        'assets/hiphop.mp3',
        metas: Metas(
          id: 'Hiphop',
          title: 'HipHop',
          artist: 'Florent Champigny',
          album: 'HipHopAlbum',
          image: MetasImage.network(
              'https://beyoudancestudio.ch/wp-content/uploads/2019/01/apprendre-danser.hiphop-1.jpg'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Task 4: Playing Local Audio and Download Audio.
    //Hint: You can use audio player packages provided by flutter.
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 300),
          Center(
            child: !isPlaying
                ? Text('Start playing audio')
                : GestureDetector(
                    onTap: () async {
                      await assetsAudioPlayer.stop();
                      isPlaying = false;
                      ss;
                    },
                    child: Column(
                      children: [
                        Container(
                          color: Colors.red,
                          height: 200,
                          width: 200,
                        ),
                        SizedBox(height: 10),
                        Text('Tap here to stop audio')
                      ],
                    ),
                  ),
          ),
          SizedBox(height: 50),
          Container(
            width: 219,
            height: 60,
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 10,
                      primary: Colors.green,
                    ),
                    onPressed: () async {
                      isLoading = true;
                      ss;
                      final snackBar = SnackBar(
                          content: Text('downloading audio, please wait!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      playUrl();

                      isLoading = false;
                      isPlaying = true;
                      ss;
                    },
                    child: Text(
                      'Download & play',
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
              onPressed: () async {
                isLoading = true;
                ss;
                playAsset();

                isLoading = false;
                isPlaying = true;
                ss;
              },
              child: Text(
                'Play local audio',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
