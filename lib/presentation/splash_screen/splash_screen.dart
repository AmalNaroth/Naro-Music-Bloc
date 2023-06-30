import 'dart:async';
import 'package:flutter/material.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/infrastructure/controller/controllers.dart';
import 'package:naromusic/presentation/bottomnavbar_root/bottomnavbar.dart';
import 'package:naromusic/presentation/home_screen/home_screen.dart';
import 'package:naromusic/presentation/user_screen/user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //value getting to sharedPreferences
  Future<void>addname()async{
    final SharedPreferences add=await SharedPreferences.getInstance();
    final addvalue=add.getString("Save_Name");
    if(addvalue!=null && addvalue.isNotEmpty){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavbar(),));
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserScreen(onAddUserName: namechecker,)));
    }
  }

  //value adding to share preference
  Future<void>namechecker(String username,String FirstChar,String LastChar)async{
    if((username.isNotEmpty && username!=null)&&(FirstChar.isNotEmpty && LastChar!=null)&&(LastChar.isNotEmpty && LastChar!=null)){
       final Sharedprefs= await SharedPreferences.getInstance();
    Sharedprefs.setString("Save_Name", username);
    
    //firstchar sharedpreference
    final firstcharacter=await SharedPreferences.getInstance();
    firstcharacter.setString("FirstChar",FirstChar);

    //lastchar sharedpreference
    final LastCharacter=await SharedPreferences.getInstance();
    LastCharacter.setString("LastChar", LastChar);
    }
  }

  @override
  void initState(){
    Timer(Duration(seconds: 3), () {
      CheckPermission();
      addname();
      allSongsValueList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Center(child: Image.asset('assets/images/Naro logo.png',height: 200,))
    );
  }
}