import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naromusic/application/favourites/favourites_bloc.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
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
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.favorite),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<FavouritesBloc, FavouritesState>(
                builder: (context, state) {
                  return Padding(
                      padding:
                          const EdgeInsets.only(right: 15, left: 15, top: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.newFavouritesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = state.newFavouritesList[index];
                          return Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 214, 214, 214),
                                  borderRadius: BorderRadius.circular(15)),
                              margin: EdgeInsets.only(bottom: 5),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
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
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.list)),
                                    IconButton(
                                        onPressed: () {
                                          //favsongslistdelete(data);
                                          context.read<FavouritesBloc>().add(
                                              FavoriteListSongDeleting(
                                                  favsongdeletesong: data));
                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                                onTap: () {
                                  playsongs(index, state.newFavouritesList);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NowPlayingScreen(
                                          data: data,
                                        ),
                                      ));
                                },
                              ));
                        },
                      ));
                },
              )
            ],
          ),
        )));
  }
}
