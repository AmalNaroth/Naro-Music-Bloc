//allsonglisting hompage songlistbar
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/domain/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/infrastructure/controller/controllers.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class songlistbar extends StatefulWidget {
  songlistbar(
      {super.key,
      required this.data,
      required this.index,
      required this.context,
      required this.songslist});

  songsmodel data;
  int index;
  BuildContext context;
  List<songsmodel> songslist;

  @override
  State<songlistbar> createState() => _songlistbarState();
}

class _songlistbarState extends State<songlistbar> {
  @override
  Widget build(BuildContext context) {
    //bool isChecking = favouritecheckings(widget.data);
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      leading: QueryArtworkWidget(
        id: widget.data.id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: CircleAvatar(
          backgroundImage: AssetImage('assets/image2/narolistlogo.png'),
        ),
      ),
      title: TextScroll(
        widget.data.songName,
        style: TextStyle(fontFamily: ""),
      ),
      subtitle: Text(
        widget.data.artistName,
        overflow: TextOverflow.ellipsis,
      ),
      tileColor: Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
               // callingBottomSheet(context, widget.data);
              },
              icon: Icon(Icons.list)),
          IconButton(
              onPressed: () {
                // setState(() {
                //   if (isChecking == false) {
                //     addtofavroutiedbfunction(widget.data, context);
                //   } else {
                //     favsongslistdelete(widget.data, context);
                //   }
                // });
              },
              // icon: isChecking == true
              //     ? Icon(Icons.favorite)
              //     : Icon(Icons.favorite_outline_outlined)
              icon: Icon(Icons.favorite),
              )
        ],
      ),
      onTap: () {
        playsongs(widget.index, allSongListNotifier.value);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => nowplayingscreen(data: widget.data),
        //     ));
       // MiniPlayer();
      },
    );
  }
}




// The home page three container Fav,Recently,Most
class ProductWidgets extends StatefulWidget {
  const ProductWidgets({super.key});

  @override
  State<ProductWidgets> createState() => _ProductWidgetsState();
}

class _ProductWidgetsState extends State<ProductWidgets> {
  List<Widget> containerNavigation = [
    // favlistscreen(),
    // recentlylistscreen(),
    // mostplayedlistScreen()
  ];

  List<String> containername = ["Favourite", "Recently Played", "Most Played"];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: SizedBox(
            width: 250,
            child: Stack(
              children: [
                SizedBox(
                  height: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      containerNavigation[index],
                                ));
                          },
                          child: Image.asset(
                            'assets/image2/image${index}.jpg',
                            height: 250,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 184, 184, 184),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 4)
                            ]),
                        child: Text(
                          containername[index],
                          style: TextStyle(
                              fontFamily: "FiraSansCondensed-Medium",
                              color: Colors.black87,
                              //fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}