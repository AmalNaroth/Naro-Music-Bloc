import 'package:flutter/material.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/domain/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/presentation/widgets/common_widgets.dart';

class recentlylistscreen extends StatefulWidget {
  const recentlylistscreen({super.key});

  @override
  State<recentlylistscreen> createState() => _recentlylistscreenState();
}

class _recentlylistscreenState extends State<recentlylistscreen> {
  @override
  Widget build(BuildContext context) {
    allrecentlyplaylistshow();
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.dark_mode,
                      color: Colors.white,
                    ),
                    Text(
                      "Recently played",
                      style: TextStyle(
                        fontFamily: "BebasNeue-Regular",
                          fontSize: 30,
                         // fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    InkWell(
                      onTap: () {
                      },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.local_play_rounded),
                        ),
                      ),
                  ],
                ),
              ),
             Padding(
          padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
          child: ValueListenableBuilder(
            valueListenable: recentlyPlayedNotifier,
           builder: (BuildContext context, List<songsmodel> recentlist, Widget? child,){
            return !recentlist.isEmpty ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            itemCount: recentlist.length,
            itemBuilder: (BuildContext context, int index) {
              final data=recentlist[index];
              return Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 214, 214, 214),
                  borderRadius: BorderRadius.circular(15)
                ),
                margin: EdgeInsets.only(bottom: 5),
                child: recentlyplayedandmostplayed(data: data, index: index, newlist: recentlist)
              );
            },
          ):Column(
            children: [
              SizedBox(height: 300,),
              Center(child: Text("NO SONGS",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500,
              fontSize: 18
              ),)),
            ],
          );
          }
          )
        )
            ],
          ),
        )));
  }
}