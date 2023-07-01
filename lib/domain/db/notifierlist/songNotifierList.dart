import 'package:flutter/material.dart';
import 'package:naromusic/domain/db/models/playlistmodel.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';


//ValueNotifier<List<songsmodel>>favsongListNotifier= ValueNotifier([]);

ValueNotifier<List<songsmodel>>recentlyPlayedNotifier= ValueNotifier([]);

ValueNotifier<List<songsmodel>>mostplayedsongNotifier=ValueNotifier([]);

ValueNotifier<List<songsmodel>>playlistsongnotifier=ValueNotifier([]);

//ValueNotifier<List<playlistmodel>>playlistnamenotifier=ValueNotifier([]);

ValueNotifier<bool>  isSongPlayingNotifier=ValueNotifier(false);