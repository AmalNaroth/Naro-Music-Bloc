part of 'playlistsongs_bloc.dart';

@immutable
class PlaylistsongsState {
  List<songsmodel> NewSongList;
  PlaylistsongsState({required this.NewSongList});
}

class PlaylistsongsInitial extends PlaylistsongsState {
  PlaylistsongsInitial():super(NewSongList: PlayListSongsListGlobal);
}
