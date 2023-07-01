part of 'songsearch_bloc.dart';

@immutable
abstract class SongsearchEvent {}

class NewSongSearchEvent extends SongsearchEvent{
  String searchSongName;
  NewSongSearchEvent({required this.searchSongName});
}