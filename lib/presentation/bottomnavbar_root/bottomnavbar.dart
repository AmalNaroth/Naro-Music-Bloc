import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:naromusic/application/bottomnav/bottomnav_bloc.dart';
import 'package:naromusic/domain/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/presentation/home_screen/home_screen.dart';
import 'package:naromusic/presentation/miniplayer_screen/miniplayer_screen.dart';
import 'package:naromusic/presentation/playlist_screen/playlist_screen.dart';
import 'package:naromusic/presentation/search_screen/search_screen.dart';

class BottomNavbar extends StatelessWidget {
   BottomNavbar({super.key});
  int index = 0;
  
  @override
  Widget build(BuildContext context) {
    List routes = [
      HomeScreen(),
      PlayListScreen(),
      SearchScreen(),
      //settings_screen()
    ];
    return BlocBuilder<BottomnavBloc, BottomnavState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: routes[state.currentIndex],
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ValueListenableBuilder(
                  valueListenable: isSongPlayingNotifier,
                  builder: (BuildContext contx, isPlay, Widget? child) {
                    return isPlay ? MiniPlayer() : const SizedBox();
                  }),
              Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: GNav(
                      gap: 8,
                      backgroundColor: Colors.transparent,
                      color: Color.fromARGB(255, 158, 155, 155),
                      activeColor: Colors.white,
                      tabBackgroundColor: Colors.grey.shade800,
                      padding: EdgeInsets.all(16),
                      onTabChange: (value) {
                        context
                            .read<BottomnavBloc>()
                            .add(ScreenChange(screenIndex: value));
                      },
                      tabs: [
                        GButton(
                          icon: Icons.home,
                          text: "Home",
                        ),
                        GButton(
                          icon: Icons.list,
                          text: "Playlist",
                        ),
                        GButton(
                          icon: Icons.search,
                          text: "Search",
                        ),
                        // GButton(
                        //   icon: Icons.settings,
                        //   text: "Premium",
                        // ),
                      ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
