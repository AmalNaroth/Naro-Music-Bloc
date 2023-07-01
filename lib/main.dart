import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naromusic/application/bottomnav/bottomnav_bloc.dart';
import 'package:naromusic/application/favourites/favourites_bloc.dart';
import 'package:naromusic/application/playlist/playlist_bloc.dart';
import 'package:naromusic/application/songsearch/songsearch_bloc.dart';
import 'package:naromusic/domain/db/models/playlistmodel.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/presentation/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(songsmodelAdapter().typeId)) {
    Hive.registerAdapter(songsmodelAdapter());
  }
  if (!Hive.isAdapterRegistered(playlistmodelAdapter().typeId)) {
    Hive.registerAdapter(playlistmodelAdapter());
  }
  await Hive.openBox<songsmodel>(boxname);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomnavBloc(),
        ),
         BlocProvider(
          create: (context) => SongsearchBloc(),
        ),
        BlocProvider(
          create: (context) => FavouritesBloc(),
        ),
        BlocProvider(
          create: (context) => PlaylistBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Color.fromARGB(255, 0, 0, 0),
                displayColor: Color.fromARGB(255, 0, 0, 0),
              ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
