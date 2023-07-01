part of 'playlist_bloc.dart';

@immutable
class PlaylistEvent {}

class NewPlayList extends PlaylistEvent{
  String newPlayListName;
  NewPlayList({required this.newPlayListName});

}

class DeletePlayList extends PlaylistEvent{
  playlistmodel deletedata;
  DeletePlayList({required this.deletedata});
}

