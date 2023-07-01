import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naromusic/application/playlist/playlist_bloc.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/playlistmodel.dart';
import 'package:naromusic/domain/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/presentation/playlist_screen/playlist_widgets/playlist_widgets.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  @override
  Widget build(BuildContext context) {
    addplaylistdbtovaluelistenable();
    final obj = createnewplaylist(context);
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
                      "P L A Y L I S T",
                      style: GoogleFonts.bebasNeue(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                    InkWell(
                      onTap: () {
                        obj.createnewolayList(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(CupertinoIcons.add),
                      ),
                    )
                  ],
                ),
              ),
              BlocBuilder<PlaylistBloc, PlaylistState>(
                builder: (context, state) {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.only(top: 20, right: 5, left: 5, bottom: 50),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            (MediaQuery.of(context).size.width - 15 - 10) /
                                (2 * 250),
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 5),
                    itemCount: allPlayListNameGlobal.length,
                    itemBuilder: (context, index) {
                      final data = state.newplayList[index];
                      if (index % 2 == 0) {
                        return PlayListListing(
                          index: index,
                          data: data,
                        );
                      }
                      return OverflowBox(
                        maxHeight: 250 + 70,
                        child: Container(
                          margin: EdgeInsets.only(top: 70),
                          child: PlayListListing(
                            index: index,
                            data: data,
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        )));
  }
}
