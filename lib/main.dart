import 'package:flutter/material.dart';
import 'package:yoseikanbudo/pages/adounat.dart';
import 'package:yoseikanbudo/pages/clubprofile.dart';
import 'package:yoseikanbudo/pages/demandelicence.dart';
import 'package:yoseikanbudo/pages/home.dart';
import 'package:yoseikanbudo/pages/joueur/homejoueur.dart';
import 'package:yoseikanbudo/pages/login.dart';
import 'package:yoseikanbudo/pages/matches.dart';
import 'package:yoseikanbudo/pages/mesmatchs.dart';
import 'package:yoseikanbudo/pages/rankingclub.dart';
import 'package:yoseikanbudo/pages/startpage.dart';
import 'package:yoseikanbudo/pages/teste.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Cairo',
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Welcome(),
        routes: {
          'Competitions': (context) {
            return Homepage();
          },
          "adounat": (context) {
            return Adounat();
          },
          "matches": (context) {
            return Matches();
          },
          "login": (context) {
            return LogIn();
          },
          "home": (context) {
            return Homepage();
          },
          "demandelicence": (context) {
            return Licence();
          },
          "rankingnational": (context) {
            return MobileDetails();
          },
          "clubprofile": (context) {
            return ClubProfile();
          },
          "homejoueur": (context) {
            return HomeJoueur();
          }
        });
  }
}
