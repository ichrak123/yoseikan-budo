import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yoseikanbudo/component/bottomnavbar.dart';

import 'package:yoseikanbudo/pages/rankingclub.dart';

class MesMatchs extends StatefulWidget {
  final username;

  const MesMatchs({Key key, this.username}) : super(key: key);

  @override
  _MesMatchsState createState() => _MesMatchsState();
}

class _MesMatchsState extends State<MesMatchs> {
  String somme, sommeone;
  Future getMesMatchTermine() async {
    var url = "http://192.168.1.6:80/federationtunisienne/getmesmatchs.php";
    var data = {
      "clubname": widget.username,
      "clubnametow": widget.username,
      "typeresultat": "Gagne par Hantei",
      "typeresultattow": "Gagne par Points"
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Future getMesMatchAvenir() async {
    var url = "http://192.168.1.6:80/federationtunisienne/progmatch.php";
    var data = {
      "clubname": widget.username,
      "clubnametow": widget.username,
      "status": " "
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            bottomNavigationBar: BottomNavBar(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(150.0),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text(
                  "Nos matchs",
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
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  color: Color(0xFFF57F17), width: 1)),
                          child: Align(child: Text("terminé"))),
                    ),
                    Tab(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Color(0xFFF57F17), width: 1)),
                          child: Align(child: Text("a venir"))),
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(children: [
              Container(
                  child: FutureBuilder(
                      future: getMesMatchTermine(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return MeMatchList(
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
                                      'http://192.168.1.6:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['h']}',
                                  imageplayerone:
                                      'http://192.168.1.6:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['i']}',
                                );
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      })),
              Container(
                  child: FutureBuilder(
                      future: getMesMatchAvenir(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return MesMatchListTow(
                                  joueurone: snapshot.data[i]['x'],
                                  joueurtow: snapshot.data[i]['y'],
                                  clubone: snapshot.data[i]['f'],
                                  clubtowtow: snapshot.data[i]['k'],
                                  competition: snapshot.data[i]['name_comp'],
                                  categorie: snapshot.data[i]['cat_name'],
                                  date: snapshot.data[i]['date'],
                                  groupe: snapshot.data[i]['nomgroupe'],
                                  tourname: snapshot.data[i]['tour_name'],
                                  lieu: snapshot.data[i]['lieu'],
                                  imageplayertow:
                                      'http://192.168.1.6:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['h']}',
                                  imageplayerone:
                                      'http://192.168.1.6:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['i']}',
                                );
                              });
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Aucun match programmé",
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                      })),
            ])));
  }
}

class MeMatchList extends StatelessWidget {
  final groupe;
  final competition;
  final categorie;
  final joueurone;
  final joueurtow;
  final clubone;
  final clubtowtow;
  final scoreone;
  final scoretow;
  final resultat;
  final date;
  final typeresult;
  final imageplayertow;
  final imageplayerone;
  final score;
  final pt;
  final moy;
  final santion;
  final technique;
  final ptone;
  final moyone;
  final santionone;
  final lieu;
  final tourname;
  final arbitrename;

  const MeMatchList({
    Key key,
    this.joueurone,
    this.joueurtow,
    this.clubone,
    this.clubtowtow,
    this.scoreone,
    this.scoretow,
    this.resultat,
    this.typeresult,
    this.imageplayertow,
    this.imageplayerone,
    this.competition,
    this.groupe,
    this.categorie,
    this.date,
    this.score,
    this.pt,
    this.moy,
    this.santion,
    this.technique,
    this.ptone,
    this.moyone,
    this.santionone,
    this.lieu,
    this.tourname,
    this.arbitrename,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        ListTile(
          title: Text(
            competition,
          ),
          subtitle: Row(
            children: [
              Text(groupe),
              SizedBox(
                width: 10,
              ),
              Text(tourname)
            ],
          ),
          trailing: Text(
            date,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return MobileDetails(
                arbitrename_d: arbitrename,
                categorie_d: categorie,
                clubtowtow_d: clubtowtow,
                clubone_d: clubone,
                competition_d: competition,
                resultat_d: resultat,
                technique_d: technique,
                moy_d: moy,
                tourname_d: tourname,
                typeresult_d: typeresult,
                imageplayerone_d: imageplayerone,
                pt_d: pt,
                ptone_d: ptone,
                moyone_d: moyone,
                imageplayertow_d: imageplayertow,
                santion_d: santion,
                santionone_d: santionone,
                score_d: score,
                scoretow_d: scoretow,
                date_d: date,
                groupe_d: groupe,
                joueurone_d: joueurone,
                joueurtow_d: joueurtow,
                lieu_d: lieu,
                scoreone_d: scoreone,
              );
            }));
          },
          child: Card(
            child: Expanded(
                child: Container(
                    child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(imageplayerone),
                        radius: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(joueurone, style: TextStyle(fontSize: 12)),
                          Text("(AKA)", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Text(clubone),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(scoreone),
                SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(int.parse(scoreone) > int.parse(scoretow)
                            ? "vainqueur : AKA"
                            : "vainqueur : AO"),
                      ],
                    ),
                    Text(
                      typeresult,
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Text(scoretow),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(imageplayertow),
                        radius: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(joueurtow, style: TextStyle(fontSize: 12)),
                          Text("(AO)", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Text(clubtowtow)
                    ],
                  ),
                ),
              ],
            ))),
          ),
        ),
      ],
    ));
  }
}

class MesMatchListTow extends StatelessWidget {
  final groupe;
  final competition;
  final categorie;
  final joueurone;
  final joueurtow;
  final clubone;
  final clubtowtow;
  final lieu;
  final date;
  final tourname;
  final imageplayertow;
  final imageplayerone;

  const MesMatchListTow({
    Key key,
    this.joueurone,
    this.joueurtow,
    this.clubone,
    this.clubtowtow,
    this.imageplayertow,
    this.imageplayerone,
    this.competition,
    this.groupe,
    this.categorie,
    this.date,
    this.lieu,
    this.tourname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        ListTile(
          title: Text(
            competition,
          ),
          subtitle: Text(lieu),
          trailing: Text(date),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 15), child: Text(tourname)),
                Text(" / "),
                Text(groupe)
              ],
            ),
            Card(
              child: Column(
                children: [
                  Container(
                    color: Colors.redAccent,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(imageplayerone),
                        radius: 20,
                      ),
                      title: Row(
                        children: [
                          Text(
                            joueurone,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text("   "),
                          Text("(aka)"),
                        ],
                      ),
                      subtitle: Text(clubone),
                    ),
                  ),
                  Container(
                    color: Colors.blueAccent,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(imageplayertow),
                        radius: 20,
                      ),
                      title: Row(
                        children: [
                          Text(
                            joueurtow,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text("   "),
                          Text("(AO)"),
                        ],
                      ),
                      subtitle: Text(clubtowtow),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }
}


// entre joueur w club set_relation_n_n