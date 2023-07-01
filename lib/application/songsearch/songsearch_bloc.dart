import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/db/models/songsmodel.dart';

part 'songsearch_event.dart';
part 'songsearch_state.dart';

class SongsearchBloc extends Bloc<SongsearchEvent, SongsearchState> {
  SongsearchBloc() : super(SongsearchInitial()) {
    on<NewSongSearchEvent>(newSongSearchEvent);
  }


  FutureOr<void> newSongSearchEvent(NewSongSearchEvent event, Emitter<SongsearchState> emit) {
       List<songsmodel> newList = allSongsListGlobal
          .where((element) =>
              element.songName.toLowerCase().startsWith(event.searchSongName.toLowerCase()))
          .toList();
          emit(SongsearchState(searchsongs: newList));
  }
}
