import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naromusic/application/playlist/playlist_bloc.dart';
import 'package:naromusic/application/playlistsongs/playlistsongs_bloc.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/playlistmodel.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/domain/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/presentation/playlist_screen/playlist_songlisting.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';


//create new playlist popup
class createnewplaylist {
  createnewplaylist(this.context);
  BuildContext context;
  final _formkey = GlobalKey<FormState>();
  final _playlisttexcontroller = TextEditingController();
  void createnewolayList(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Playlist creation",
          style: TextStyle(fontFamily: "BebasNeue-Regular", fontSize: 25),
        ),
        content: Form(
          key: _formkey,
          child: TextFormField(
            decoration:
                InputDecoration(label: Text("Enter your playlist name")),
            controller: _playlisttexcontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the playlist name';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  _submitForm();
                  _playlisttexcontroller.clear();
                }
              },
              child: Text(
                "Create",
                style: TextStyle(color: Colors.black),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(color: Colors.black)))
        ],
      ),
    );
  }

  void _submitForm() {
    final textValue = _playlisttexcontroller.text;
    print('textcontroller = ${textValue}');
    //List<songsmodel> listarray = [];
   // addplaylisttodatabase(textValue, listarray, context);
   context.read<PlaylistBloc>().add(NewPlayList(newPlayListName: textValue));
    Navigator.pop(context);
  }
}



//playlist container showing
class PlayListListing extends StatelessWidget {
  PlayListListing({super.key, required this.index, required this.data});
  int index;
  playlistmodel data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayListSongListing(data: data),
            ),
          );
        },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  "assets/image2/image2.jpg",
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.playlistname,
                            style: TextStyle(
                              fontFamily: "FiraSansCondensed-Medium",
                              overflow: TextOverflow.ellipsis,
                              fontSize: 30,
                              //fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Songs count",
                            style: TextStyle(
                              fontFamily: "FiraSansCondensed-Medium",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // playlistdelete(data, context);
                      },
                        child: PopupMenuButton(
                            color: Colors.black,
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                     // playlistdelete(data);
                                     context.read<PlaylistBloc>().add(DeletePlayList(deletedata: data));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Delete Playlist'),
                                        Icon(Icons.delete)
                                      ],
                                    ),
                                  )),
                                  PopupMenuItem(
                                      child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      final obj2 = playlistnameupdate(
                                        context,
                                        index,
                                        data.playlistname,
                                      );
                                      obj2.createnewolayList(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Change name'),
                                        Icon(Icons.edit)
                                      ],
                                    ),
                                  ))
                                ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}

//songslisting adding time listing in bottommodel plus

void callingBottomSheetsonglisting(BuildContext context, String listname) {
  addplaylistdbtovaluelistenable();
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'A L L S O N G S L I S T',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black45,
                  fontFamily: "BebasNeue-Regular"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: allSongsListGlobal.length,
              itemBuilder: (BuildContext context, int index) {
                final data = allSongsListGlobal[index];
                return Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(12)),
                    margin: EdgeInsets.only(bottom: 5, right: 15, left: 15),
                    child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: QueryArtworkWidget(
                          id: data.id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/image2/narolistlogo.png'),
                          ),
                        ),
                        title: TextScroll(
                          data.songName,
                        ),
                        subtitle: Text(
                          data.artistName,
                          overflow: TextOverflow.ellipsis,
                        ),
                        tileColor:
                            Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
                        trailing: IconButton(
                            onPressed: () {
                              // songaddtoplaylistdatabase(
                              //     listname, data);
                              context.read<PlaylistsongsBloc>().add(PlayListAddingEvent(PlayListName: listname, NewSongData: data));
                            },
                            icon: Icon(Icons.add,color: Colors.black,))));
              },
            ),
          ),
        ],
      ),
    ),
  );
}

//playlist nameupdating
class playlistnameupdate {
  playlistnameupdate(this.context, this.index, this.playlistname);
  BuildContext context;
  int index;
  String playlistname;

  final _formkey = GlobalKey<FormState>();
  final _playlisttexcontroller = TextEditingController();
  void createnewolayList(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Playlist creation",
          style: TextStyle(fontFamily: "BebasNeue-Regular", fontSize: 25),
        ),
        content: Form(
          key: _formkey,
          child: TextFormField(
            decoration:
                InputDecoration(label: Text("Enter your new playlist name")),
            controller: _playlisttexcontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the playlist name';
              }
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  _submitForm();
                }
              },
              child: Text(
                "Create",
                style: TextStyle(color: Colors.black),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(color: Colors.black)))
        ],
      ),
    );
  }

  void _submitForm() {
    final textValue = _playlisttexcontroller.text;
    print('textcontroller = ${textValue}');
    List<songsmodel> listarray = [];
    playlistrename(textValue, context, index, playlistname);
    Navigator.pop(context);
  }
}


