//allsonglisting hompage songlistbar
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naromusic/application/favourites/favourites_bloc.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/domain/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/infrastructure/controller/controllers.dart';
import 'package:naromusic/presentation/home_screen/fav-rec-most/favourite-songs_screen.dart';
import 'package:naromusic/presentation/home_screen/fav-rec-most/mostplayed-songs_screen.dart';
import 'package:naromusic/presentation/home_screen/fav-rec-most/recentlyplayed-songs_screen.dart';
import 'package:naromusic/presentation/miniplayer_screen/miniplayer_screen.dart';
import 'package:naromusic/presentation/nowplaying_screen/nowplaying_screen.dart';
import 'package:naromusic/presentation/widgets/common_widgets.dart';
import 'package:naromusic/presentation/widgets/show_dialoges.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_scroll/text_scroll.dart';


//homepage single song bar
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
    bool isChecking = favouritecheckings(widget.data);
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
                callingBottomSheet(context, widget.data);
              },
              icon: Icon(Icons.list)),
          IconButton(
              onPressed: () {
                setState(() {
                  if (isChecking == false) {
                    //addtofavroutiedbfunction(widget.data);
                    context.read<FavouritesBloc>().add(FavoriteListSongAdding(newfavsongdata: widget.data));
                  } else {
                    //favsongslistdelete(widget.data);
                    context.read<FavouritesBloc>().add(FavoriteListSongDeleting(favsongdeletesong: widget.data));
                  }
                });
              },
              icon: isChecking == true
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_outline_outlined))
        ],
      ),
      onTap: () {
        playsongs(widget.index, allSongsListGlobal);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NowPlayingScreen(data: widget.data),
            ));
        MiniPlayer();
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
     favlistscreen(),
    recentlylistscreen(),
    mostplayedlistScreen()
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

//drawer
class drawerlist extends StatefulWidget {
  drawerlist({super.key});

  @override
  State<drawerlist> createState() => _drawerlistState();
}

class _drawerlistState extends State<drawerlist> {
  String? savedName;
  String? firstchar;
  String? LastChar;
  //sharedpreference
  Future<void> username() async {
    final SharedPreferences sharedPrefs1 =
        await SharedPreferences.getInstance();
    final SharedPreferences sharedPrefs2 =
        await SharedPreferences.getInstance();
    final SharedPreferences sharedPrefs3 =
        await SharedPreferences.getInstance();
    setState(() {
      savedName = sharedPrefs1.getString('Save_Name');
      print(savedName);
      firstchar = sharedPrefs2.getString("FirstChar");
      LastChar = sharedPrefs3.getString("LastChar");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    username();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              (savedName != null) ? savedName.toString() : "Hello User",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            accountEmail: TextScroll(
                "Experience the power of music like never before with",
                style: TextStyle(fontSize: 15, color: Colors.white)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              child: savedName != null
                  ? Text(
                      "$firstchar$LastChar",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    )
                  : Text("UR",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
              //Text(,style: TextStyle(fontSize: 30),),
            ),
            decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                    image: AssetImage(
                      "assets/image2/drawerBackground.jpg",
                    ),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("About"),
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationName: "NARO MUSIC",
                  applicationIcon: Image.asset(
                    "assets/image2/narolistlogo.png",
                    height: 32,
                    width: 32,
                  ),
                  applicationVersion: "1.0.1",
                  children: [
                    const Text(
                        "NARO MUSIC is an offline music player app which allows use to hear music from their local storage and also do functions like add to favorites , create playlists , recently played , mostly played etc."),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("App developed by Amal N.")
                  ]);
              leading:
              const Icon(
                Icons.person,
                size: 35,
                color: Colors.white,
              );
              title:
              const Text(
                "About",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                    fontSize: 18),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share"),
            onTap: () {},
          ),
          // ListTile(
          //   leading: Icon(Icons.notifications),
          //   title: Text("Notificaton"),
          //   onTap: () {},
          // ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text("Terms and Conditions"),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return privacydialoge(
                        mdFileName: "terms_and_conditions.md");
                  });
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text("Privacy and Policy"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return privacydialoge(mdFileName: "privacy_policy.md");
                },
              );
            },
          )
        ],
      ),
    );
  }
} //**drwer */