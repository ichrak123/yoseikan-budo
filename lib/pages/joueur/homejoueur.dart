import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:yoseikanbudo/component/bottomnavbar.dart';
import 'package:yoseikanbudo/component/bottomnavbarjoueur.dart';
import 'package:yoseikanbudo/component/complist.dart';
import 'package:yoseikanbudo/component/mydrawer.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoseikanbudo/component/mydrawerjoueur.dart';

import 'package:yoseikanbudo/pages/adounat.dart';
import 'package:yoseikanbudo/pages/joueur/examengradejoueur.dart';
import 'package:yoseikanbudo/pages/joueur/unseennotificationjoueur.dart';
import 'package:yoseikanbudo/pages/startpage.dart';
import 'package:yoseikanbudo/pages/teste.dart';
import 'package:yoseikanbudo/pages/unseenNotificationPage.dart';

import '../ourcoachs.dart';
import '../ourplayers.dart';
import 'Mesmatchjoueur.dart';

class HomeJoueur extends StatefulWidget {
  final usernameone;
  const HomeJoueur({Key key, this.usernameone}) : super(key: key);

  @override
  _HomeJoueurState createState() => _HomeJoueurState();
}

class _HomeJoueurState extends State<HomeJoueur> {
  var username;
  var club;
  var id;
  var nomprenom;
  var image;

  bool isSignIn = false;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");
    club = preferences.getString("club");
    id = preferences.getString("joueur_id");
    nomprenom = preferences.getString("nomprenom");
    image = preferences.getString("image");

    if (username != null) {
      setState(() {
        username = preferences.getString("username");
        id = preferences.getString("joueur_id");
        club = preferences.getString("club");
        nomprenom = preferences.getString("nomprenom");
        image = preferences.getString("image");

        isSignIn = true;
      });
    }
  }

  var listsearch = [];
  Future getSearch() async {
    var url = "http://192.168.1.4:80/federationtunisienne/getsearch.php";
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    for (int i = 0; i < responsebody.length; i++) {
      listsearch.add(responsebody[i]['name_comp']);
    }
    print(listsearch);
  }

  bool isSeen = true;
  var total;
  Future getTotalUnseenNotificationjoueur() async {
    var data = {
      "clubname": widget.usernameone,
      "clubnametow": widget.usernameone
    };
    var url =
        "http://192.168.1.4:80/federationtunisienne/unseennotificationjoueur.php";
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      setState(() {
        total = response.body;
      });
    }
    print(total);
  }

  @override
  void initState() {
    getSearch();
    getTotalUnseenNotificationjoueur();
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: BottomNavBarjoueur(),
      appBar: AppBar(
        actions: [
          isSeen
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  unseenNotificationPagejoueur(
                                    usename: id,
                                  ))).whenComplete(
                          () => getTotalUnseenNotificationjoueur());
                    },
                    child: Badge(
                      badgeContent:
                          Text('$total', style: TextStyle(color: Colors.white)),
                      child: Icon(Icons.notifications_active, size: 30),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {},
                    child: Badge(
                      badgeContent:
                          Text('0', style: TextStyle(color: Colors.white)),
                      child: Icon(Icons.notifications_none, size: 30),
                    ),
                  ),
                )
        ],
        title: Text(''),
        elevation: 0,
        backgroundColor: Color(0xFF80DEEA),
      ),
      drawer: DrawerMenujoueur(),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              height: size.height * .25,
              decoration: BoxDecoration(
                color: Color(0xFF80DEEA),
              )),
          SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Row(
                  children: [
                    Text("Bienvenue ",
                        style: TextStyle(
                            color: Color(0xFF263238),
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    isSignIn
                        ? Text(nomprenom != null ? nomprenom : "",
                            style: TextStyle(
                                color: Color(0xFF263238),
                                fontSize: 25,
                                fontWeight: FontWeight.bold))
                        : Text(""),
                  ],
                )),
                Container(
                    child: Row(
                  children: [
                    Text("Club :",
                        style: TextStyle(
                            color: Color(0xFF263238),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    isSignIn
                        ? Text("esperence",
                            style: TextStyle(
                                color: Color(0xFF263238),
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                        : Text(""),
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 1,
                  padding:
                      const EdgeInsets.only(bottom: 60, right: 60, left: 60),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 25,
                  children: [
                    categorycard(
                      title: "Mes matchs",
                      imagesrc: 'assets/images/matches.jpg',
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MesMatchsJoueur(
                                      username: id,
                                    )));
                      },
                    ),
                    categorycard(
                      title: "Examens de grades",
                      imagesrc: 'assets/images/exam.jpg',
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GradeJoueur(
                                      username: id,
                                    )));
                      },
                    ),
                  ],
                )),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class categorycard extends StatelessWidget {
  final String imagesrc;
  final String title;
  final id;
  final Function press;

  const categorycard({
    Key key,
    this.imagesrc,
    this.title,
    this.id,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, right: 15, left: 15, bottom: 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 20,
                spreadRadius: -5,
                color: Color(0xFFE6E6E6))
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Column(
            children: [
              Image.asset(
                imagesrc,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF263238),
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchData extends SearchDelegate<String> {
  List<dynamic> list;
  SearchData({this.list});
  Future Filter() async {
    var url = "http://192.168.1.4:80/federationtunisienne/filter.php";
    var data = {"searchcompetition": query};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // action for appbar

    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon leading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // result searchs
    return FutureBuilder(
        future: Filter(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return CompList(
                    name: snapshot.data[i]['name_comp'],
                    date: snapshot.data[i]['date_comp'],
                    poid: snapshot.data[i]['poid_comp'],
                    sexe: snapshot.data[i]['sexe_comp'],
                    id: snapshot.data[i]['id_comp'],
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchlist =
        query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
        itemCount: searchlist.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(searchlist[i]),
            onTap: () {
              query = searchlist[i];
              showResults(context);
            },
          );
        });
  }
}
