import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/domain/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/infrastructure/controller/controllers.dart';
import 'package:naromusic/presentation/nowplaying_screen/nowplaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/material.dart';

class favlistscreen extends StatefulWidget {
  const favlistscreen({super.key});

  @override
  State<favlistscreen> createState() => _favlistscreenState();
}

class _favlistscreenState extends State<favlistscreen> {
  @override
  Widget build(BuildContext context) {
    allsongsfavlistshow();
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
                      "Favourite",
                      style: TextStyle(
                        fontFamily: "BebasNeue-Regular",
                          fontSize: 30,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    InkWell(
                      onTap: () {
                      },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.favorite),
                        ),
                      ),
                  ],
                ),
              ),
             Padding(
          padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
          child: ValueListenableBuilder(
            valueListenable: favsongListNotifier,
           builder: (BuildContext context, List<songsmodel> favlist, Widget? child,){
            return !favlist.isEmpty ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            itemCount: favlist.length,
            itemBuilder: (BuildContext context, int index) {
              final data=favlist[index];
              return Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 214, 214, 214),
                  borderRadius: BorderRadius.circular(15)
                ),
                margin: EdgeInsets.only(bottom: 5),
                child: ListTile(
                shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),),
                   leading: QueryArtworkWidget(id: data.id, type:ArtworkType.AUDIO,
                   nullArtworkWidget: CircleAvatar(backgroundImage: AssetImage('assets/image2/narolistlogo.png'),),
                   ),
                   title: Text(data.songName,overflow: TextOverflow.ellipsis,),
                   subtitle: Text(data.artistName,overflow: TextOverflow.ellipsis,),
                   tileColor: Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
                   trailing: Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       IconButton(onPressed: () {
                         
                       }, icon: Icon(Icons.list)),
                       IconButton(
                           onPressed: () {
                            favsongslistdelete(data,context);
                           },
                           icon: Icon(Icons.delete))
                     ],
                   ),
                   onTap: () {
                     playsongs(index, favlist);
                     Navigator.push(context, MaterialPageRoute(builder: (context) => NowPlayingScreen(data: data,),));
                   },
                ));
            },
          ):Column(
            children: [
              SizedBox(height: 300,),
              Center(child: Text("NO SONGS",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500,
              fontSize: 18
              ),)),
            ],
          );
          }
          )
        )
            ],
          ),
        )));
  }
}

