import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:yoseikanbudo/component/matchlist.dart';

class Matches extends StatefulWidget {
  final competitionname;
  final competitionid;

  const Matches({Key key, this.competitionname, this.competitionid})
      : super(key: key);

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  Future getQuartsdefinale() async {
    var url = "http://192.168.1.4:80/federationtunisienne/getmatch.php";
    var data = {
      "tour_name": "1/8-finals",
      "competition_name": widget.competitionid,
      "typeresultat": "Gagné par points",
      "typeresultattow": "Gagné par Hantei"
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    print(responsebody);
    return responsebody;
  }

  Future getDemifinales() async {
    var url = "http://192.168.1.4:80/federationtunisienne/getmatch.php";
    var data = {
      "tour_name": "Quarter-finals",
      "competition_name": widget.competitionid,
      "typeresultat": "Gagné par points",
      "typeresultattow": "Gagné par Hantei"
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future getSemiFinal() async {
    var url = "http://192.168.1.4:80/federationtunisienne/getmatch.php";
    var data = {
      "tour_name": "Semi-finals",
      "competition_name": widget.competitionid,
      "typeresultat": "Gagné par points",
      "typeresultattow": "Gagné par Hantei"
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future getFinal() async {
    var url = "http://192.168.1.4:80/federationtunisienne/getmatch.php";
    var data = {
      "tour_name": "final",
      "competition_name": widget.competitionid,
      "typeresultat": "Gagné par points",
      "typeresultattow": "Gagné par Hantei"
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);

    return responsebody;
  }

  Future getthirdplace() async {
    var url = "http://192.168.1.4:80/federationtunisienne/getmatch.php";
    var data = {
      "tour_name": "troisième place",
      "competition_name": widget.competitionid,
      "typeresultat": "Gagné par points",
      "typeresultattow": "Gagné par Hantei"
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              widget.competitionname,
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Color(0xFFF57F17),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xFFF57F17),
              ),
              tabs: [
                Tab(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: Color(0xFFF57F17), width: 1)),
                      child: Align(child: Text("1/8"))),
                ),
                Tab(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: Color(0xFFF57F17), width: 1)),
                      child: Align(child: Text("1/4"))),
                ),
                Tab(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: Color(0xFFF57F17), width: 1)),
                      child: Align(child: Text("1/2"))),
                ),
                Tab(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: Color(0xFFF57F17), width: 1)),
                      child: Align(child: Text("final"))),
                ),
                Tab(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: Color(0xFFF57F17), width: 1)),
                      child: Align(child: Text("3éme place"))),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: FutureBuilder(
                  future: getQuartsdefinale(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return MatchList(
                            joueurone: snapshot.data[i]['x'],
                            joueurtow: snapshot.data[i]['y'],
                            clubone: snapshot.data[i]['f'],
                            clubtowtow: snapshot.data[i]['k'],
                            scoreone: snapshot.data[i]['somme'],
                            scoretow: snapshot.data[i]['sommeone'],
                            resultat: snapshot.data[i]['vainqueur'],
                            typeresult: snapshot.data[i]['type_resultat'],
                            competition: snapshot.data[i]['name_comp'],
                            groupe: snapshot.data[i]['nomgroupe'],
                            categorie: snapshot.data[i]['cat_name'],
                            date: snapshot.data[i]['date'],
                            ptone: snapshot.data[i]['ptone'],
                            moy: snapshot.data[i]['moy'],
                            santion: snapshot.data[i]['santion'],
                            technique: snapshot.data[i]['score'],
                            pt: snapshot.data[i]['pt'],
                            moyone: snapshot.data[i]['moyone'],
                            santionone: snapshot.data[i]['santionone'],
                            lieu: snapshot.data[i]['lieu'],
                            tourname: snapshot.data[i]['tour_name'],
                            score: snapshot.data[i]['scoreone'],
                            imageplayertow:
                                'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['h']}',
                            imageplayerone:
                                'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['i']}',
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
            Container(
              child: FutureBuilder(
                  future: getDemifinales(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return MatchList(
                            joueurone: snapshot.data[i]['x'],
                            joueurtow: snapshot.data[i]['y'],
                            clubone: snapshot.data[i]['f'],
                            clubtowtow: snapshot.data[i]['k'],
                            scoreone: snapshot.data[i]['somme'],
                            scoretow: snapshot.data[i]['sommeone'],
                            resultat: snapshot.data[i]['vainqueur'],
                            typeresult: snapshot.data[i]['type_resultat'],
                            competition: snapshot.data[i]['name_comp'],
                            groupe: snapshot.data[i]['nomgroupe'],
                            categorie: snapshot.data[i]['cat_name'],
                            date: snapshot.data[i]['date'],
                            ptone: snapshot.data[i]['ptone'],
                            moy: snapshot.data[i]['moy'],
                            santion: snapshot.data[i]['santion'],
                            technique: snapshot.data[i]['score'],
                            pt: snapshot.data[i]['pt'],
                            moyone: snapshot.data[i]['moyone'],
                            santionone: snapshot.data[i]['santionone'],
                            lieu: snapshot.data[i]['lieu'],
                            tourname: snapshot.data[i]['tour_name'],
                            score: snapshot.data[i]['scoreone'],
                            imageplayertow:
                                'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['h']}',
                            imageplayerone:
                                'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['i']}',
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
            Container(
              child: FutureBuilder(
                  future: getSemiFinal(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return MatchList(
                            joueurone: snapshot.data[i]['x'],
                            joueurtow: snapshot.data[i]['y'],
                            clubone: snapshot.data[i]['f'],
                            clubtowtow: snapshot.data[i]['k'],
                            scoreone: snapshot.data[i]['somme'],
                            scoretow: snapshot.data[i]['sommeone'],
                            resultat: snapshot.data[i]['vainqueur'],
                            typeresult: snapshot.data[i]['type_resultat'],
                            competition: snapshot.data[i]['name_comp'],
                            groupe: snapshot.data[i]['nomgroupe'],
                            categorie: snapshot.data[i]['cat_name'],
                            date: snapshot.data[i]['date'],
                            ptone: snapshot.data[i]['ptone'],
                            moy: snapshot.data[i]['moy'],
                            santion: snapshot.data[i]['santion'],
                            technique: snapshot.data[i]['score'],
                            pt: snapshot.data[i]['pt'],
                            moyone: snapshot.data[i]['moyone'],
                            santionone: snapshot.data[i]['santionone'],
                            lieu: snapshot.data[i]['lieu'],
                            tourname: snapshot.data[i]['tour_name'],
                            score: snapshot.data[i]['scoreone'],
                            imageplayertow:
                                'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['h']}',
                            imageplayerone:
                                'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['i']}',
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
            Container(
              child: FutureBuilder(
                  future: getFinal(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return MatchList(
                            joueurone: snapshot.data[i]['x'],
                            joueurtow: snapshot.data[i]['y'],
                            clubone: snapshot.data[i]['f'],
                            clubtowtow: snapshot.data[i]['k'],
                            scoreone: snapshot.data[i]['somme'],
                            scoretow: snapshot.data[i]['sommeone'],
                            resultat: snapshot.data[i]['vainqueur'],
                            typeresult: snapshot.data[i]['type_resultat'],
                            competition: snapshot.data[i]['name_comp'],
                            groupe: snapshot.data[i]['nomgroupe'],
                            categorie: snapshot.data[i]['cat_name'],
                            date: snapshot.data[i]['date'],
                            ptone: snapshot.data[i]['ptone'],
                            moy: snapshot.data[i]['moy'],
                            santion: snapshot.data[i]['santion'],
                            technique: snapshot.data[i]['score'],
                            pt: snapshot.data[i]['pt'],
                            moyone: snapshot.data[i]['moyone'],
                            santionone: snapshot.data[i]['santionone'],
                            lieu: snapshot.data[i]['lieu'],
                            tourname: snapshot.data[i]['tour_name'],
                            score: snapshot.data[i]['scoreone'],
                            imageplayertow:
                                'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['h']}',
                            imageplayerone:
                                'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['i']}',
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
            Container(
              child: FutureBuilder(
                  future: getthirdplace(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return MatchList(
                            joueurone: snapshot.data[i]['x'],
                            joueurtow: snapshot.data[i]['y'],
                            clubone: snapshot.data[i]['f'],
                            clubtowtow: snapshot.data[i]['k'],
                            scoreone: snapshot.data[i]['somme'],
                            scoretow: snapshot.data[i]['sommeone'],
                            resultat: snapshot.data[i]['vainqueur'],
                            typeresult: snapshot.data[i]['type_resultat'],
                            competition: snapshot.data[i]['name_comp'],
                            groupe: snapshot.data[i]['nomgroupe'],
                            categorie: snapshot.data[i]['cat_name'],
                            date: snapshot.data[i]['date'],
                            ptone: snapshot.data[i]['ptone'],
                            moy: snapshot.data[i]['moy'],
                            santion: snapshot.data[i]['santion'],
                            technique: snapshot.data[i]['score'],
                            pt: snapshot.data[i]['pt'],
                            moyone: snapshot.data[i]['moyone'],
                            santionone: snapshot.data[i]['santionone'],
                            lieu: snapshot.data[i]['lieu'],
                            tourname: snapshot.data[i]['tour_name'],
                            score: snapshot.data[i]['scoreone'],
                            imageplayertow:
                                'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['h']}',
                            imageplayerone:
                                'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['i']}',
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
