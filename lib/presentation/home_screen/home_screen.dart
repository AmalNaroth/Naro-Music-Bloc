import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/playlistmodel.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/domain/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/presentation/home_screen/home_widgets.dart';
import 'package:naromusic/presentation/playlist_screen/playlist_songlisting.dart';

final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AllsongsdatashowList();
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: Material(
            color: Color.fromARGB(255, 255, 255, 255),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (context) {
                            return IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: Icon(Icons.more_vert),
                            );
                          },
                        ),
                        Text(
                          "N A R O M U S I C",
                          // style: TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.w500,
                          //     color: Colors.black54),
                          style: GoogleFonts.bebasNeue(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => search_screen(),));
                            },
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.headphones_outlined)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 290,
                      child: ProductWidgets(),
                    ),
                    SizedBox(
                        height: 65,
                        child: ValueListenableBuilder(
                          valueListenable: playlistnamenotifier,
                          builder: (BuildContext context,
                              List<playlistmodel> playlistname, Widget? child) {
                            return !playlistname.isEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: playlistname.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final data = playlistname[index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                PlayListSongListing(
                                                    data: data),
                                          ));
                                        },
                                        child: Center(
                                            child: Text(
                                          data.playlistname,
                                          style: TextStyle(
                                              fontFamily:
                                                  "FiraSansCondensed-Medium",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        )),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text("No play list",
                                        style: GoogleFonts.beVietnamPro(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: Colors.grey.shade700)),
                                  );
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Y O U R S O N G S",
                      // style: GoogleFonts.aBeeZee(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w500,
                      //     color: Colors.black54),
                      style: TextStyle(
                          fontFamily: "FiraSansCondensed-Medium",
                          fontSize: 20,
                          color: Colors.black54),
                    ),
                    ValueListenableBuilder(
                        valueListenable: allSongListNotifier,
                        builder: (BuildContext context,
                            List<songsmodel> newlist, Widget? child) {
                          return !newlist.isEmpty
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: newlist.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final data = newlist[index];
                                    return Container(
                                      margin:
                                          EdgeInsets.only(bottom: 5, right: 15),
                                      child: songlistbar(
                                          data: data,
                                          index: index,
                                          context: context,
                                          songslist: newlist),
                                    );
                                  })
                              : Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 60,
                                      ),
                                      Text(
                                        "No songs found",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                );
                        })
                  ],
                ),
              ),
            ),
          ),
          drawer: drawerlist()
        ),
      ),
    );
  }
}
