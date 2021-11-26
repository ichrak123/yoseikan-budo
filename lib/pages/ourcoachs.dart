import 'package:flutter/material.dart';
import 'package:yoseikanbudo/component/bottomnavbar.dart';
import 'package:yoseikanbudo/component/coachlist.dart';
import 'package:yoseikanbudo/component/complist.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yoseikanbudo/component/joueurlist.dart';

class OurCoachs extends StatefulWidget {
  final clubname;

  const OurCoachs({
    Key key,
    this.clubname,
  }) : super(key: key);

  @override
  _OurCoachsState createState() => _OurCoachsState();
}

class _OurCoachsState extends State<OurCoachs> {
  var listsearch = [];
  Future getSearch() async {
    var url = "http://192.168.1.4:80/federationtunisienne/getsearchcoach.php";
    var data = {"club": widget.clubname};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    for (int i = 0; i < responsebody.length; i++) {
      listsearch.add(responsebody[i]['nomcoach']);
    }
    print(listsearch);
  }

  @override
  void initState() {
    getSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future noscoachs() async {
      var url = "http://192.168.1.4:80/federationtunisienne/noscoachs.php";
      var data = {"club": widget.clubname};
      var response = await http.post(url, body: data);
      var responsebody = jsonDecode(response.body);
      return responsebody;
    }

    Future noscoachsenattente() async {
      var url =
          "http://192.168.1.4:80/federationtunisienne/noscoachsenattente.php";
      var data = {"club": widget.clubname};
      var response = await http.post(url, body: data);
      var responsebody = jsonDecode(response.body);
      return responsebody;
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          bottomNavigationBar: BottomNavBar(),
          appBar: AppBar(
            title: Text(
              "nos coachs",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.search, size: 30),
                onPressed: () {
                  showSearch(
                      context: context, delegate: SearchData(list: listsearch));
                },
              ),
            ],
            backgroundColor: Color(0xFF00ACC1),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(
                    child: Text(
                  "en attente",
                  style: TextStyle(fontSize: 20),
                )),
                Tab(child: Text("Licenciés", style: TextStyle(fontSize: 20))),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                child: FutureBuilder(
                    future: noscoachsenattente(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return CoachList(
                              namecoach: snapshot.data[i]['nomcoach'],
                              numlicencecoach: snapshot.data[i]
                                  ['numerolicence'],
                              phonecoach: snapshot.data[i]['phone'],
                              emailcoach: snapshot.data[i]['email'],
                              datenaissancecoach: snapshot.data[i]
                                  ['datenaissance'],
                              adressecoach: snapshot.data[i]['adresse'],
                              gradecoach: snapshot.data[i]['gradecoach'],
                              avatarUrlcoach:
                                  'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['image']}',
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: FutureBuilder(
                    future: noscoachs(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return CoachList(
                              namecoach: snapshot.data[i]['nomcoach'],
                              numlicencecoach: snapshot.data[i]
                                  ['numerolicence'],
                              phonecoach: snapshot.data[i]['phone'],
                              emailcoach: snapshot.data[i]['email'],
                              datenaissancecoach: snapshot.data[i]
                                  ['datenaissance'],
                              adressecoach: snapshot.data[i]['adresse'],
                              gradecoach: snapshot.data[i]['gradecoach'],
                              avatarUrlcoach:
                                  'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['image']}',
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ],
          )),
    );
  }
}

class SearchData extends SearchDelegate<String> {
  List<dynamic> list;
  SearchData({this.list});
  Future Filtercoach() async {
    var url = "http://192.168.1.4:80/federationtunisienne/filtercoach.php";
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
        future: Filtercoach(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return CoachList(
                    namecoach: snapshot.data[i]['nomcoach'],
                    numlicencecoach: snapshot.data[i]['numerolicence'],
                    phonecoach: snapshot.data[i]['phone'],
                    emailcoach: snapshot.data[i]['email'],
                    datenaissancecoach: snapshot.data[i]['datenaissance'],
                    adressecoach: snapshot.data[i]['adresse'],
                    gradecoach: snapshot.data[i]['gradecoach'],
                    avatarUrlcoach:
                        'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['image']}',
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
