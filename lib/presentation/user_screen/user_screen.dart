import 'package:flutter/material.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/presentation/bottomnavbar_root/bottomnavbar.dart';
import 'package:naromusic/presentation/home_screen/home_screen.dart';

class UserScreen extends StatelessWidget {
   UserScreen({super.key, required this.onAddUserName});

   final void Function(String username, String FirstChar, String LastChar)
      onAddUserName;

  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  String? imagepath;
  final _formkey = GlobalKey<FormState>();
  String? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.graphic_eq_outlined,
                  size: 60,
                ),
                //hello again
                SizedBox(
                  height: 15,
                ),
                Text("N A R O M U S I C",
                    style: TextStyle(
                        fontFamily: "BebasNeue-Regular", fontSize: 54)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome back you've been missed!",
                  style: TextStyle(fontSize: 30, fontFamily: "Cookie-Regular"),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                //username screen
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: _firstnamecontroller,
                        decoration: InputDecoration(
                            label: Text("First name"),
                            border: InputBorder.none),
                        validator: (value) {
                          if (_firstnamecontroller.text == null ||
                              _firstnamecontroller.text.isEmpty) {
                            return "Enter your first name";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                //last name
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: _lastnamecontroller,
                        decoration: InputDecoration(
                            label: Text("Last name"), border: InputBorder.none),
                        validator: (value) {
                          if (_lastnamecontroller.text.isEmpty ||
                              _lastnamecontroller.text == null ) {
                            return "Enter the last name";
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      usernameinsharedpreference();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (route) => false);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(25),
                    margin: EdgeInsetsDirectional.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                        child: Text(
                      "Start",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                //skip
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavbar(),
                          ));
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void usernameinsharedpreference() async {
    if ((_firstnamecontroller.text != null &&
            _firstnamecontroller.text.isNotEmpty) &&
        (_lastnamecontroller.text != null &&
            _lastnamecontroller.text.isNotEmpty)) {
      String firstCharacter1 = _firstnamecontroller.text.substring(0, 1);
      String firstCharacter2 = _lastnamecontroller.text.substring(0, 1);
      String result =_firstnamecontroller.text + " " + _lastnamecontroller.text;
      onAddUserName(result.toString(), firstCharacter1.toString(),
          firstCharacter2.toString());
      print(result + " " + firstCharacter1 + "   " + firstCharacter2);
    }
  }
  }