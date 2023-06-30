// music slider in nowplaying screen
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naromusic/presentation/home_screen/home_screen.dart';

class musicsliders extends StatefulWidget {
  musicsliders({super.key});

  @override
  State<musicsliders> createState() => _musicslidersState();
}

class _musicslidersState extends State<musicsliders> {
  double slidervalue = 0;

  double duration = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.current.listen((event) {
      final totalduration = event!.audio.duration;
      duration = event.audio.duration.inSeconds.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.currentPosition(
      player: audioPlayer,
      builder: (context, position) {
        slidervalue = position.inSeconds.toDouble();

        return Column(
          children: [
            Slider(
              value: slidervalue,
              min: 0.0,
              max: duration,
              onChanged: (value) {
                slidervalue = value;
                audioPlayer.seek(Duration(seconds: slidervalue.toInt()));
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal:20.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [

            //       PlayerBuilder.currentPosition(player: audioPlayer, builder: (context, position) {
            //       final mm = (position.inMinutes %60).toString().padLeft(2,'0');
            //       final ss = (position.inSeconds %60).toString().padLeft(2,'0');
            //       return Text('${mm}:${ss}');
            //     },),
            //     PlayerBuilder.current(player: audioPlayer, builder: (context, playing) {
            //       final totalduration = playing.audio.duration;
            //       final mm = (totalduration.inMinutes %60).toString().padLeft(2,'0');
            //       final ss = (totalduration.inSeconds %60).toString().padLeft(2,'0');
            //       return Text('${mm}:${ss}');
            //     },)

            //   ],),
            // )
          ],
        );
      },
    );
  }
}