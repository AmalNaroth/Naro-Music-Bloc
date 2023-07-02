part of 'playlistsongs_bloc.dart';

@immutable
abstract class PlaylistsongsEvent {}

class PlayListAddingEvent extends PlaylistsongsEvent{
  String PlayListName;
  songsmodel NewSongData;

  PlayListAddingEvent({required this.PlayListName,required this.NewSongData});
}

class PlayListDeleteEvent extends PlaylistsongsEvent{
  String DeletePlayListName;
  songsmodel DeleteSongData;
  PlayListDeleteEvent({required this.DeletePlayListName,required this.DeleteSongData});

}

class PlayListOpenShowing extends PlaylistsongsEvent{
  List<songsmodel> spotshowlist;
  PlayListOpenShowing({required this.spotshowlist});
}