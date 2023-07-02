import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';

import '../../domain/db/models/playlistmodel.dart';
import '../../domain/db/models/songsmodel.dart';

part 'playlistsongs_event.dart';
part 'playlistsongs_state.dart';

class PlaylistsongsBloc extends Bloc<PlaylistsongsEvent, PlaylistsongsState> {
  PlaylistsongsBloc() : super(PlaylistsongsInitial()) {
   on<PlayListAddingEvent>(playListAddingEvent);
   on<PlayListDeleteEvent>(playListDeleteEvent);
   on<PlayListOpenShowing>(playListOpenShowing);

  }

  FutureOr<void> playListAddingEvent(PlayListAddingEvent event, Emitter<PlaylistsongsState> emit) {

    songaddtoplaylistdatabase(event.PlayListName, event.NewSongData);
    emit(PlaylistsongsState(NewSongList: PlayListSongsListGlobal));
  }

  FutureOr<void> playListDeleteEvent(PlayListDeleteEvent event, Emitter<PlaylistsongsState> emit) {
    songsdeletefromplaylist(event.DeleteSongData, event.DeletePlayListName);
    emit(PlaylistsongsState(NewSongList: PlayListSongsListGlobal));
  }

  FutureOr<void> playListOpenShowing(PlayListOpenShowing event, Emitter<PlaylistsongsState> emit) {
    emit(PlaylistsongsState(NewSongList: PlayListSongsListGlobal));
  }
}
