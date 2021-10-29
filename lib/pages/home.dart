import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:yoseikanbudo/component/bottomnavbar.dart';
import 'package:yoseikanbudo/component/complist.dart';
import 'package:yoseikanbudo/component/mydrawer.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yoseikanbudo/pages/adounat.dart';
import 'package:yoseikanbudo/pages/startpage.dart';
import 'package:yoseikanbudo/pages/teste.dart';
import 'package:yoseikanbudo/pages/unseenNotificationPage.dart';

import 'demandelicence.dart';
import 'mesmatchs.dart';

class Homepage extends StatefulWidget {
  final usernameone;
  const Homepage({Key key, this.usernameone}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var username;
  var nomclub;
  var id;
  var clubresponsable;

  bool isSignIn = false;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");
    nomclub = preferences.getString("nom_club");
    id = preferences.getString("id_club");
    clubresponsable = preferences.getString("club_responsable");

    if (username != null) {
      setState(() {
        username = preferences.getString("username");
        id = preferences.getString("id_club");
        nomclub = preferences.getString("nom_club");
        clubresponsable = preferences.getString("club_responsable");

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
  Future getTotalUnseenNotification() async {
    var url =
        "http://192.168.1.4:80/federationtunisienne/unseennotification.php";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        total = response.body;
      });
    }
    print(total);
  }

  @override
  void initState() {
    getPref();
    getTotalUnseenNotification();
    getSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Future getCategory() async {
      var url = "http://192.168.1.4:80/federationtunisienne/getcategories.php";

      var response = await http.get(url);
      var responsebody = jsonDecode(response.body);
      return responsebody;
    }

    return Scaffold(
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
                                      unseenNotificationPage()))
                          .whenComplete(() => getTotalUnseenNotification());
                      debugPrint("seen");
                    },
                    child: Badge(
                      badgeContent:
                          Text('$total', style: TextStyle(color: Colors.white)),
                      child: Icon(Icons.notifications_active),
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
                      child: Icon(Icons.notifications_none),
                    ),
                  ),
                )
        ],
        title: Text(''),
        elevation: 0,
        backgroundColor: Color(0xFFE0F2F1),
      ),
      drawer: DrawerMenu(),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              height: size.height * .25,
              decoration: BoxDecoration(color: Color(0xFFE0F2F1))),
          SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(" "),
                ),
                Container(
                  child: Text("Choisir une categorie",
                      style: TextStyle(
                          color: Color(0xFF263238),
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: SearchData(list: listsearch));
                    },
                    child: Row(
                      children: [
                        IconButton(
                          color: Colors.grey,
                          icon: Icon(Icons.search),
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: SearchData(list: listsearch));
                          },
                        ),
                        Text(
                          "Rechercher Competition",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: FutureBuilder(
                        future: getCategory(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: .85,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return categorycard(
                                    imagesrc:
                                        'http://192.168.1.4:80/federationtunisienne/uploads/${snapshot.data[index]['imagesrc']}',
                                    title: snapshot.data[index]['title'],
                                    id: snapshot.data[index]['cat_id'],
                                  );
                                });
                          } else {
                            return CircularProgressIndicator();
                          }
                        }))
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

  const categorycard({
    Key key,
    this.imagesrc,
    this.title,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, right: 15, left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 17,
                spreadRadius: -23,
                color: Color(0xFFE6E6E6))
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Adounat(
                          categoryname: id,
                          titlename: title,
                        )));
          },
          child: Column(
            children: [
              Image.network(imagesrc, height: 90, width: 90),
              SizedBox(height: 10),
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF263238),
                      fontSize: 17,
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
