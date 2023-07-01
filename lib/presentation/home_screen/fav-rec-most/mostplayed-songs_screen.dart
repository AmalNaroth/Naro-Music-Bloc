import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/domain/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/presentation/widgets/common_widgets.dart';

class mostplayedlistScreen extends StatefulWidget {
  const mostplayedlistScreen({super.key});

  @override
  State<mostplayedlistScreen> createState() => _mostplayedlistScreenState();
}

class _mostplayedlistScreenState extends State<mostplayedlistScreen> {
  @override
  Widget build(BuildContext context) {
    allMostPlayedListShow();
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
                      "Most played",
                      style: TextStyle(
                          fontSize: 30,
                          //fontWeight: FontWeight.bold,
                          fontFamily: "BebasNeue-Regular",
                          color: Colors.black54),
                    ),
                    InkWell(
                      onTap: () {
                      },
                    
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.sports_volleyball_outlined),
                      ),
                    )
                  ],
                ),
              ),
             Padding(
          padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
          child: ValueListenableBuilder(
            valueListenable: mostplayedsongNotifier,
           builder: (BuildContext context, List<songsmodel> mostplayed, Widget? child,){
            return !mostplayed.isEmpty ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            itemCount: mostplayed.length,
            itemBuilder: (BuildContext context, int index) {
              final data=mostplayed[index];
              return !mostplayed.isEmpty ? Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 214, 214, 214),
                  borderRadius: BorderRadius.circular(15)
                ),
                margin: EdgeInsets.only(bottom: 5),
                child: recentlyplayedandmostplayed(data: data, index: index, newlist: mostplayed)
              ):Text("No songs");
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