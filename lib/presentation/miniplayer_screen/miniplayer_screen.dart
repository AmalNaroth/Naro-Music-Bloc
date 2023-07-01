import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naromusic/presentation/home_screen/home_screen.dart';
import 'package:naromusic/presentation/nowplaying_screen/nowplaying_screen.dart';
import 'package:naromusic/presentation/ui-functions/ui_functions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniPlayer extends StatefulWidget {
   MiniPlayer({super.key,});


  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderCurrent(builder: (cntx, playing) {
      // resentPlyed(int.parse(playing.audio.audio.metas.id!));
      // mostPlayAdd(int.parse(playing.audio.audio.metas.id!));
      int songid = int.parse(playing.audio.audio.metas.id!);
        findsong(songid);
      return GestureDetector(
          onTap: () {
            final data = findsongwithid(int.parse(playing.audio.audio.metas.id.toString()));
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> NowPlayingScreen(data:data)));

            //    Navigator.push(context, MaterialPageRoute(builder: (cntx) {
            //   return nowplayingscreen(data: ,);
            // }));
          },
          child: Container(
            width: double.infinity,
            height: 80,
            decoration:  BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image2/miniplayerbg.jpg"),
                    fit: BoxFit.cover),
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)
                    ),
            child: ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
                    leading: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black,
                        child: QueryArtworkWidget(
                          id: int.parse(playing.audio.audio.metas.id!),
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: CircleAvatar(backgroundImage: AssetImage("assets/image2/narolistlogo.png"),),
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: TextScroll(
                            playing.audio.audio.metas.title!,
                            velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                            pauseBetween: Duration(milliseconds: 1000),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    // subtitle: Text('artist'),
                    subtitle: Wrap(
                      children: [
                        SizedBox(width: 35,),
                        IconButton(
                            onPressed: () {
                              audioPlayer.previous();
                            },
                            color: Colors.white,
                            // iconSize: 35,
                            icon: Icon(Icons.skip_previous_rounded)),
                        PlayerBuilder.isPlaying(player: audioPlayer, builder: (context, isPlaying) {
                          return IconButton(
                            onPressed: () {
                              if (isPlaying) {
                                audioPlayer.pause();
                                
                              } else {
                                audioPlayer.play();
                                
                              }
                            },
                            // iconSize: 30,
                            color: Colors.white,
                            icon: isPlaying
                                ? Icon(Icons.pause)
                                : Icon(Icons.play_arrow));
                        },),
                        IconButton(
                            onPressed: () {
                              audioPlayer.next();
                            },
                            color: Colors.white,
                            // iconSize: 35,
                            icon: Icon(Icons.skip_next_rounded)),
                        // IconButton(
                        //     onPressed: () {
                        //       audioPlayer.stop();
                        //       setState(() {
                        //         isPlaying = false;
                        //         // isSongPlayingNotifier.value = isPlaying;
                        //         // isSongPlayingNotifier.notifyListeners();
                        //       });
                        //     },
                        //     color: Colors.white,
                        //     // iconSize: 35,
                        //     icon: Icon(Icons.stop)),
                      ],
                    ),
                  )),
            ),
          ));
    });
  }
}
