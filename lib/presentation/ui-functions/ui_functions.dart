import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';

void findsong(int id){
  for(var element in allSongsListGlobal){
    if(element.id==id){
     addrecentlyplayed(element);
     mostPlayedSongs(element);
     break;
    }
  }
}


songsmodel findsongwithid(int songid){
  late songsmodel data;
  for(var element in allSongsListGlobal){
    
    if(songid == element.id){
     
    data =  element;
    }
  }

  return data;

}