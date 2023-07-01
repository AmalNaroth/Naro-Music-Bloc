part of 'playlist_bloc.dart';

@immutable
class PlaylistState {
  List<playlistmodel> newplayList;
  PlaylistState({required this.newplayList});
}

class PlaylistInitial extends PlaylistState {

  PlaylistInitial() : super(newplayList: allPlayListNameGlobal);
}

