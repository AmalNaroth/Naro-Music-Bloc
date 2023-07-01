import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naromusic/domain/db/models/playlistmodel.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';
import 'package:naromusic/presentation/splash_screen/splash_screen.dart';
void main() {
 Hive.initFlutter();
  if(!Hive.isAdapterRegistered(songsmodelAdapter().typeId)){
    Hive.registerAdapter(songsmodelAdapter());
  }
  if(!Hive.isAdapterRegistered(playlistmodelAdapter().typeId)){
    Hive.registerAdapter(playlistmodelAdapter());
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}