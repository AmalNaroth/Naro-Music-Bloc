import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/presentation/home_screen/home_screen.dart';
import 'package:naromusic/presentation/nowplaying_screen/nowplaying_widgets.dart';
import 'package:naromusic/presentation/ui-functions/ui_functions.dart';
import 'package:naromusic/presentation/widgets/common_widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

bool isshuffle = false;
bool isloop = false;

class NowPlayingScreen extends StatefulWidget {
  NowPlayingScreen({super.key, required this.data});

  final songsmodel data;

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  bool playstate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: audioPlayer.builderCurrent(
      builder: (context, playing) {
        int songid = int.parse(playing.audio.audio.metas.id!);
        findsong(songid);
        songsmodel songdata = findsongwithid(songid);
        bool ischeck= favouritecheckings(songdata);
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 25, left: 25, top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: NeuBox(
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_drop_down)),
                        ),
                      ),
                      Text(
                        "N A R O M U S I C",
                        style: TextStyle(
                            fontFamily: "BebasNeue-Regular",
                            fontSize: 30,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: NeuBox(
                            child: PopupMenuButton(
                                color: Colors.white,
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                          child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          //callingBottomSheet(context, songdata);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Add to playlist'),
                                            Icon(Icons.add),
                                          ],
                                        ),
                                      )),
                                    ])),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  //cover art,song name artist name
                  NeuBox(
                      child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 280,
                            width: 280,
                            child: QueryArtworkWidget(
                                id: int.parse(playing.audio.audio.metas.id!),
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: ClipRect(
                                  child: Image.asset(
                                      'assets/images/Naro logo.png'),
                                )),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextScroll(playing.audio.audio.metas.title!,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.grey.shade700)),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  TextScroll(
                                    playing.audio.audio.metas.artist!,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if(ischeck==false){
                                      addtofavroutiedbfunction(widget.data,);
                                    }else{
                                      favsongslistdelete(widget.data);
                                    }
                                  });
                                },
                                icon:
                                     ischeck==true?
                                    Icon(Icons.favorite,size: 32,):
                                    Icon(
                                  Icons.favorite_outline_outlined,
                                  size: 32,
                                ))
                          ],
                        ),
                      )
                    ],
                  )),
                  SizedBox(
                    height: 30,
                  ),

                  //start time shuffle end time repeact icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PlayerBuilder.currentPosition(
                        player: audioPlayer,
                        builder: (context, position) {
                          final mm = (position.inMinutes % 60)
                              .toString()
                              .padLeft(2, '0');
                          final ss = (position.inSeconds % 60)
                              .toString()
                              .padLeft(2, '0');
                          return Text('${mm}:${ss}');
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (isshuffle == false) {
                                audioPlayer.toggleShuffle();
                                isshuffle = true;
                              } else {
                                audioPlayer.toggleShuffle();
                                isshuffle = false;
                              }
                            });
                          },
                          icon: isshuffle == false
                              ? Icon(Icons.shuffle)
                              : Icon(
                                  Icons.shuffle,
                                  color: Colors.amber,
                                )),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (isloop == false) {
                              audioPlayer.setLoopMode(LoopMode.single);
                              isloop = true;
                            } else {
                              audioPlayer.setLoopMode(LoopMode.playlist);
                              isloop = false;
                            }
                          });
                        },
                        icon: isloop == false
                            ? Icon(Icons.repeat)
                            : Icon(
                                Icons.repeat,
                                color: Colors.amber,
                              ),
                      ),
                      PlayerBuilder.current(
                        player: audioPlayer,
                        builder: (context, playing) {
                          final totalduration = playing.audio.duration;
                          final mm = (totalduration.inMinutes % 60)
                              .toString()
                              .padLeft(2, '0');
                          final ss = (totalduration.inSeconds % 60)
                              .toString()
                              .padLeft(2, '0');
                          return Text('${mm}:${ss}');
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  //linear bar,

                  NeuBox(
                    // child: LinearPercentIndicator(
                    //   lineHeight: 10,
                    //   percent: 0.5,
                    //   progressColor: Colors.blue.shade400,
                    //   backgroundColor: Colors.transparent,
                    // ),
                    child: musicsliders(),
                  ),

                  SizedBox(
                    height: 35,
                  ),
                  //previous next skip
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                            child: NeuBox(
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        audioPlayer.previous();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.skip_previous,
                                      size: 32,
                                    )))),
                        Expanded(
                            flex: 2,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: NeuBox(
                                    child: PlayerBuilder.isPlaying(
                                  player: audioPlayer,
                                  builder: (context, isPlaying) {
                                    return IconButton(
                                        onPressed: () {
                                          if (isPlaying == false) {
                                            audioPlayer.play();
                                          } else {
                                            audioPlayer.pause();
                                          }
                                        },
                                        icon: isPlaying == false
                                            ? Icon(
                                                Icons.play_arrow,
                                                size: 32,
                                              )
                                            : Icon(
                                                Icons.pause,
                                                size: 32,
                                              ));
                                  },
                                )))),
                        Expanded(
                            child: NeuBox(
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        audioPlayer.next();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.skip_next,
                                      size: 32,
                                    ))))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
