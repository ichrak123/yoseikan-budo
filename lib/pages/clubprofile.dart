import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:yoseikanbudo/pages/mesmatchs.dart';
import 'dart:convert';

import 'package:yoseikanbudo/pages/rankingclub.dart';

class ClubProfile extends StatefulWidget {
  const ClubProfile({Key key}) : super(key: key);

  @override
  _ClubProfileState createState() => _ClubProfileState();
}

class _ClubProfileState extends State<ClubProfile> {
  var username;
  var nomclub;
  var clubresponsable;
  var id;
  var nombreentraineur;
  var nombrejoueur;
  var apropos;
  var email;
  bool isSignIn = false;
  int _selectedIndex = 0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      nomclub = preferences.getString("nom_club");
      id = preferences.getString("id_club");
      clubresponsable = preferences.getString("club_responsable");
      nombreentraineur = preferences.getString("nombreentraineur");
      nombrejoueur = preferences.getString("nombrejoueur");
      apropos = preferences.getString("apropos");
      email = preferences.getString("email");
      if (username != null) {
        setState(() {
          username = preferences.getString("username");
          nomclub = preferences.getString("nom_club");
          id = preferences.getString("id_club");
          clubresponsable = preferences.getString("club_responsable");
          nombreentraineur = preferences.getString("nombreentraineur");
          nombrejoueur = preferences.getString("nombrejoueur");
          apropos = preferences.getString("apropos");
          email = preferences.getString("email");

          isSignIn = true;
        });
      }
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFFE0F2F1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(color: Color(0xFFE0F2F1)),
                  child: Container(
                    width: double.infinity,
                    height: 350.0,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              "assets/images/logo.jpg",
                              height: 80,
                              width: 80,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          isSignIn
                              ? Text(
                                  nomclub != null ? nomclub : 'Default Value',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Color(0xFF263238),
                                  ),
                                )
                              : Text(""),
                          SizedBox(
                            height: 10.0,
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 22.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "joueurs",
                                          style: TextStyle(
                                            color: Color(0xFFF57F17),
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        isSignIn
                                            ? Text(
                                                nombrejoueur != null
                                                    ? nombrejoueur
                                                    : 'Default Value',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color(0xFF263238),
                                                ),
                                              )
                                            : Text(""),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Coachs",
                                          style: TextStyle(
                                            color: Color(0xFFF57F17),
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        isSignIn
                                            ? Text(
                                                nombreentraineur != null
                                                    ? nombreentraineur
                                                    : 'Default Value',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color(0xFF263238),
                                                ),
                                              )
                                            : Text(""),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "A propos",
                        style: TextStyle(
                            color: Color(0xFFF57F17),
                            fontStyle: FontStyle.normal,
                            fontSize: 28.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'My name is Alice and I am  a freelance mobile app developper.\n'
                        'if you need any mobile app for your company then contact me for more informations',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF263238),
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
