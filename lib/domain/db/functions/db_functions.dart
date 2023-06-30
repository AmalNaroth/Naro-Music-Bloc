import 'package:hive_flutter/adapters.dart';
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

//all songs adding value listenable
 Future<void> allSongsValueList() async{
  final allsongdatabase= await Hive.openBox<songsmodel>(boxname);
  allSongListNotifier.value.clear();
  allSongListNotifier.value.addAll(allsongdatabase.values.toList());
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