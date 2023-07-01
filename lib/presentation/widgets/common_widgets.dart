//common white shade design
import 'package:flutter/material.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/playlistmodel.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/domain/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/infrastructure/controller/controllers.dart';
import 'package:naromusic/presentation/nowplaying_screen/nowplaying_screen.dart';
import 'package:naromusic/presentation/playlist_screen/playlist_widgets/playlist_widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class NeuBox extends StatefulWidget {
  final child;
  NeuBox({super.key, required this.child});

  @override
  State<NeuBox> createState() => _NeuBoxState();
}

class _NeuBoxState extends State<NeuBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(
        child: widget.child,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 15,
                offset: Offset(
                  5,
                  5,
                )),
            BoxShadow(
                color: Colors.white, blurRadius: 15, offset: Offset(-5, -5))
          ]),
    );
  }
}

// songs adding play list Search screen and home Screen
void callingBottomSheet(BuildContext context, songsmodel songdata) {
  addplaylistdbtovaluelistenable();
  final obj = createnewplaylist(context);
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    context: context,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 230, 230, 230),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      height: 400,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'P L A Y L I S T',
            style: TextStyle(
                fontFamily: "BebasNeue-Regular",
                fontSize: 30,
                color: Colors.black45,
                fontWeight: FontWeight.w500),
          ),
          IconButton(
              onPressed: () {
                obj.createnewolayList(context);
              },
              icon: Icon(
                Icons.add_circle,
                size: 40,
              )),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: !allPlayListNameGlobal.isEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: allPlayListNameGlobal.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = allPlayListNameGlobal[index];
                      return Container(
                          height: 65,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(12)),
                          margin: EdgeInsets.only(
                              bottom: 5, right: 15, left: 15),
                          child: Center(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/image2/narolistlogo.png'),
                              ),
                              title: TextScroll(
                                data.playlistname,
                                style: TextStyle(
                                    fontSize: 20,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w400),
                              ),
                              tileColor: Color.fromARGB(0, 136, 136, 136)
                                  .withOpacity(0.3),
                              onTap: () {
                                Navigator.of(context).pop();
                                songaddtoplaylistdatabase(
                                    data.playlistname, songdata, context);
                              },
                            ),
                          ));
                    },
                  )
                : Center(
                    child: Text(
                      "No playlist",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ),
          ),
        ],
      ),
    ),
  );
}

//recentplay and most play listing listviewbuilder
class recentlyplayedandmostplayed extends StatelessWidget {
  recentlyplayedandmostplayed(
      {super.key,
      required this.data,
      required this.index,
      required this.newlist});
  songsmodel data;
  int index;
  List<songsmodel> newlist;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      leading: QueryArtworkWidget(
        id: data.id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: CircleAvatar(
          backgroundImage: AssetImage('assets/image2/narolistlogo.png'),
          radius: 25,
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
      tileColor: Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
      onTap: () {
        playsongs(index, newlist);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NowPlayingScreen(
                data: data,
              ),
            ));
      },
    );
  }
}