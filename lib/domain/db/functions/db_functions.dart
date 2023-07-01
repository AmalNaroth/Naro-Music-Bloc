import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naromusic/domain/db/models/playlistmodel.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/domain/db/notifierlist/songNotifierList.dart';
import 'package:on_audio_query/on_audio_query.dart';

void addallsongsdb(SongModel data) async {
  final allsongdatabase = await Hive.openBox<songsmodel>(boxname);

  final newnongs = songsmodel(
      songName: data.displayName,
      artistName: data.artist!,
      uri: data.uri!,
      id: data.id,
      duration: data.duration!);

  bool flag = true;

  for (var elements in allsongdatabase.values) {
    if (elements.id == newnongs.id) {
      flag = false;
    }
  }
  if (flag == true) {
    allsongdatabase.add(newnongs);
  }
}


AllsongsdatashowToList() async {
  final allsongdatabase = await Hive.openBox<songsmodel>(boxname);
  allSongsListGlobal.clear();
  allSongsListGlobal.addAll(allsongdatabase.values);
}

// Future<void> checksongs() async{
//   final allsongdatabase = await Hive.openBox<songsmodel>(boxname);
//   for(var sample in allsongdatabase.values){
//     print(sample.songName);
//   }
// }

//  checksongsvaluelist() {
//   for(var sample in allSongListNotifier.value){
//     print(sample.songName);
//   }
// }

addtofavroutiedbfunction(songsmodel data, BuildContext context) async {
  final favrioutedatabase = await Hive.openBox<songsmodel>("favlistDB");
  bool check = false;
  for (var elements in favrioutedatabase.values) {
    if (data.id == elements.id) {
      check = true;
    }
  }
  if (check == false) {
    favrioutedatabase.add(data);
    favsongListNotifier.notifyListeners();
   // allSongListNotifier.notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Add to Favorites"),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 1),
    ));
  }
  allsongsfavlistshow();
}

allsongsfavlistshow() async {
  final favrioutedatabase = await Hive.openBox<songsmodel>("favlistDB");
  favsongListNotifier.value.clear();
  favsongListNotifier.value.addAll(favrioutedatabase.values);
  favsongListNotifier.notifyListeners();
}

favsongslistdelete(songsmodel data, BuildContext context) async {
  final favrioutedatabase = await Hive.openBox<songsmodel>("favlistDB");
  int count = 0;
  for (var elements in favrioutedatabase.values) {
    if (data.id == elements.id) {
      favrioutedatabase.deleteAt(count);
      favsongListNotifier.notifyListeners();
      //allSongListNotifier.notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Song removed"),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ));
    }
    count++;
  }
  allsongsfavlistshow();
}

Future<void> addrecentlyplayed(songsmodel data) async {
  final recentlyplayeddatabae =
      await Hive.openBox<songsmodel>("recentlyplayeddb");
  int count = 0;
  for (var elements in recentlyplayeddatabae.values) {
    count++;
  }
  if (count > 4) {
    recentlyplayeddatabae.deleteAt(0);
  }
  int index = 0;
  for (var element in recentlyplayeddatabae.values) {
    if (element.id == data.id) {
      recentlyplayeddatabae.deleteAt(index);
    }
    index++;
  }
  recentlyplayeddatabae.add(data);
  allrecentlyplaylistshow();
}

allrecentlyplaylistshow() async {
  final recentlyplayeddatabae =
      await Hive.openBox<songsmodel>("recentlyplayeddb");
  recentlyPlayedNotifier.value.clear();
  recentlyPlayedNotifier.value.addAll(recentlyplayeddatabae.values);
  recentlyPlayedNotifier.value =
      List<songsmodel>.from(recentlyPlayedNotifier.value.reversed);
  recentlyPlayedNotifier.notifyListeners();
}

void mostPlayedSongs(songsmodel data) async {
  final mostplayedDB = await Hive.openBox<songsmodel>('mostplayedDB');
  //data.count = data.count + 1;
  int mostplayedcount = 0;
  int count = 0;
  for (var element in mostplayedDB.values) {
    count++;
  }
  if (count > 20) {
    mostplayedDB.deleteAt(0);
  }
  int index = 0;
  for (var element in mostplayedDB.values) {
    if (data.id == element.id) {
      mostplayedcount = element.count + 1;
      mostplayedDB.deleteAt(index);
    }
    index++;
  }
  final newsong = songsmodel(
      songName: data.songName,
      artistName: data.songName,
      uri: data.uri,
      id: data.id,
      duration: data.duration,
      count: mostplayedcount);
  mostplayedDB.add(newsong);

  allMostPlayedListShow();
}

void allMostPlayedListShow() async {
  final mostplayedDB = await Hive.openBox<songsmodel>('mostplayedDB');
  mostplayedsongNotifier.value.clear();
  for (var element in mostplayedDB.values) {
    if (element.count > 10) {
      mostplayedsongNotifier.value.add(element);
    }
  }
  for (int i = 0; i < mostplayedsongNotifier.value.length; i++) {
    for (int j = i + 1; j < mostplayedsongNotifier.value.length; j++) {
      if (mostplayedsongNotifier.value[i].count <
          mostplayedsongNotifier.value[j].count) {
        songsmodel temp = mostplayedsongNotifier.value[i];
        mostplayedsongNotifier.value[i] = mostplayedsongNotifier.value[j];
        mostplayedsongNotifier.value[j] = temp;
      }
    }
  }
  mostplayedsongNotifier.notifyListeners();
}

bool favouritecheckings(songsmodel data) {
  for (var elements in favsongListNotifier.value) {
    if (data.id == elements.id) {
      return true;
    }
  }
  return false;
}

//playlistadding
//palylist name adding
addplaylisttodatabase(
    String listname, List<songsmodel> listarray, context) async {
  final playlistDB = await Hive.openBox<playlistmodel>('playlistDB');
  bool flag = true;
  for (var element in playlistDB.values) {
    if (listname == element.playlistname) {
      flag = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Already added'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  if (flag == true) {
    final newplaylsit =
        playlistmodel(playlistname: listname, playlistarray: listarray);
    playlistDB.add(newplaylsit);
    addplaylistdbtovaluelistenable();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Playlist created'),
      behavior: SnackBarBehavior.floating,
    ));
  }
}

addplaylistdbtovaluelistenable() async {
  final playlistDB = await Hive.openBox<playlistmodel>('playlistDB');
  playlistnamenotifier.value.clear();
  playlistnamenotifier.value.addAll(playlistDB.values);
  playlistnamenotifier.notifyListeners();
}

// void palylist() async{
//   final playListDB=await Hive.openBox<playlistmodel>('playlistdb');
//   for(var element in playListDB.values){
//     print(element.playlistname);
//   }
// }

playlistdelete(playlistmodel data, BuildContext context) async {
  final playlistDB = await Hive.openBox<playlistmodel>('playlistDB');
  int count = 0;
  for (var element in playlistDB.values) {
    if (element.playlistname == data.playlistname) {
      playlistDB.deleteAt(count);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Deleted playlist"),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ));
    }
    count++;
  }
  addplaylistdbtovaluelistenable();
}

songaddtoplaylistdatabase(String listname, songsmodel songdata, context) async {
  final playlistDB = await Hive.openBox<playlistmodel>('playlistDB');
  int index = 0;
  List<songsmodel> newplayarray = [];
  bool flag = true;
  for (var element in playlistDB.values) {
    if (listname == element.playlistname) {
      newplayarray = element.playlistarray;
      for (var element in newplayarray) {
        if (songdata.id == element.id) {
          flag = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('The song is already exists'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 1)));
          return;
        }
      }
      if (flag == true) {
        newplayarray.add(songdata);
        final newplaylist =
            playlistmodel(playlistname: listname, playlistarray: newplayarray);
        playlistDB.putAt(index, newplaylist);
        playlistnamenotifier.notifyListeners();
        playlistsongnotifier.notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Song added to playlist'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ));
      }
    }
    index++;
  }
}

songsdeletefromplaylist(songsmodel data, String name) async {
  final playlistDB = await Hive.openBox<playlistmodel>('playlistDB');
  int index = 0;
  List<songsmodel> newlist;
  for (var element in playlistDB.values) {
    if (name == element.playlistname) {
      for (var elements in element.playlistarray) {
        if (data.id == elements.id) {
          element.playlistarray.remove(elements);
          newlist = element.playlistarray;
          final newplaylist =
              playlistmodel(playlistname: name, playlistarray: newlist);
          playlistDB.putAt(index, newplaylist);
          playlistsongnotifier.notifyListeners();
          playlistsongnotifier.notifyListeners();
          break;
        }
      }
    }
    index++;
  }
}

//playlist updating
void playlistrename(String newlistname, BuildContext context, int index,
    String playlistoldname) async {
  final playlistdb = await Hive.openBox<playlistmodel>("playlistDB");

  List<songsmodel> newlist = [];
  bool value = true;
  for (var elements in playlistdb.values) {
    if (newlistname == elements.playlistname) {
      value = false;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("The name is already exists"),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
  if (value = true) {
    for (var element in playlistdb.values) {
      if (playlistoldname == element.playlistname) {
        newlist = element.playlistarray;
      }
    }
    final newplaylist =
        playlistmodel(playlistname: newlistname, playlistarray: newlist);
    playlistdb.putAt(index, newplaylist);
    addplaylistdbtovaluelistenable();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Updated playlist name"),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
