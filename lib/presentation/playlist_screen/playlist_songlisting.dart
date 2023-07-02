import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/playlistmodel.dart';
import 'package:naromusic/infrastructure/controller/controllers.dart';
import 'package:naromusic/presentation/nowplaying_screen/nowplaying_screen.dart';
import 'package:naromusic/presentation/playlist_screen/playlist_widgets/playlist_widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../application/playlistsongs/playlistsongs_bloc.dart';

//PLAYLIST INSIDE SONG LISTING
class PlayListSongListing extends StatefulWidget {
  PlayListSongListing({super.key, required this.data});
  playlistmodel data;

  @override
  State<PlayListSongListing> createState() => _PlayListSongListingState();
}

class _PlayListSongListingState extends State<PlayListSongListing> {
  @override
  Widget build(BuildContext context) {
    PlayListSongsListGlobal = widget.data.playlistarray;
    context
        .read<PlaylistsongsBloc>()
        .add(PlayListOpenShowing(spotshowlist: PlayListSongsListGlobal));
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.dark_mode,
                      color: Colors.white,
                    ),
                    Text(
                      widget.data.playlistname,
                      style: TextStyle(
                          fontFamily: "BebasNeue-Regular",
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                    InkWell(
                      onTap: () {
                        callingBottomSheetsonglisting(
                            context, widget.data.playlistname);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(CupertinoIcons.add),
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: 30,
              // ),
              BlocBuilder<PlaylistsongsBloc, PlaylistsongsState>(
                builder: (context, state) {
                  return Padding(
                      padding:
                          const EdgeInsets.only(right: 15, left: 15, top: 10),
                      child: !state.NewSongList.isEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.NewSongList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final data = state.NewSongList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 217, 217, 217),
                                      borderRadius: BorderRadius.circular(15)),
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    leading: QueryArtworkWidget(
                                      id: data.id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/image2/narolistlogo.png'),
                                      ),
                                    ),
                                    title: Text(
                                      data.songName,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      data.artistName,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    tileColor: Color.fromARGB(0, 136, 136, 136)
                                        .withOpacity(0.3),
                                    trailing: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.grey
                                                            .withOpacity(0.8),
                                                        Colors.white
                                                            .withOpacity(0.8),
                                                        Colors.grey
                                                            .withOpacity(0.8),
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                  child: AlertDialog(
                                                    title: Text('Alert'),
                                                    content: Text(
                                                        'Are you sure you want to delete?'),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        child: Text('Cancel'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Close the alert dialog
                                                        },
                                                      ),
                                                      ElevatedButton(
                                                        child: Text('OK'),
                                                        onPressed: () {
                                                          // Perform an action
                                                          Navigator.of(context)
                                                              .pop();
                                                          // songsdeletefromplaylist(
                                                          //     data,
                                                          //     widget.data
                                                          //         .playlistname);
                                                          context
                                                              .read<
                                                                  PlaylistsongsBloc>()
                                                              .add(PlayListDeleteEvent(
                                                                  DeletePlayListName:
                                                                      widget
                                                                          .data
                                                                          .playlistname,
                                                                  DeleteSongData:
                                                                      data));
                                                        },
                                                      ),
                                                    ],
                                                  ));
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.delete)),
                                    onTap: () {
                                      playsongs(index, state.NewSongList);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NowPlayingScreen(
                                              data: data,
                                            ),
                                          ));
                                    },
                                  ),
                                );
                              },
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 300,
                                ),
                                Center(
                                    child: Text(
                                  "NO SONGS",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                )),
                              ],
                            ));
                },
              )
            ],
          ),
        )));
  }
}
