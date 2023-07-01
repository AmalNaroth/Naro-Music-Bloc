part of 'songsearch_bloc.dart';

@immutable
class SongsearchState {
  List<songsmodel> searchsongs;
  SongsearchState({required this.searchsongs});
}

class SongsearchInitial extends SongsearchState {
  SongsearchInitial() : super(searchsongs: allSongsListGlobal);
}
