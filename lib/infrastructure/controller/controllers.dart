import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/domain/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/presentation/home_screen/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

final audioquery = OnAudioQuery();
final audioplyer = AssetsAudioPlayer();
List<Audio> audio = [];

List<SongModel> allsongsList = [];
List<SongModel> Mp3songsList = [];
List<songsmodel> allsongs = [];

CheckPermission() async {
  final permission = await Permission.storage.request();
  if (permission.isGranted) {
    allsongsList = await audioquery.querySongs();

    for (var elements in allsongsList) {
      if (elements.fileExtension == "mp3") {
        Mp3songsList.add(elements);
      }
    }

    for (var elements in Mp3songsList) {
      addallsongsdb(elements);
    }
  } else {
    CheckPermission();
  }
}

playsongs(index, List songlist) {
  bool isPlaying = true;
  isSongPlayingNotifier.value = isPlaying;
  isSongPlayingNotifier.notifyListeners();
  audio.clear();
  for (var elements in songlist) {
    audio.add(Audio.file(elements.uri,
        metas: Metas(
            id: elements.id.toString(),
            artist: elements.artistName,
            title: elements.songName)));
  }
  audioPlayer.open(Playlist(audios: audio, startIndex: index),
      autoStart: true,
      showNotification: true,
      loopMode: LoopMode.playlist,
      notificationSettings: NotificationSettings(stopEnabled: false));
}
