import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MesMatchsJoueur extends StatefulWidget {
  final username;

  const MesMatchsJoueur({Key key, this.username}) : super(key: key);

  @override
  _MesMatchsJoueurState createState() => _MesMatchsJoueurState();
}

class _MesMatchsJoueurState extends State<MesMatchsJoueur> {
  Future getMesMatch() async {
    var url = "http://10.0.2.2:80/federationtunisienne/gemesmatchjoueurs.php";
    var data = {
      "joueurname": widget.username,
      "joueurnametow": widget.username
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mes matchs"),
        ),
        body: Container(
            child: FutureBuilder(
                future: getMesMatch(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return MeMatchList(
                            joueurone: snapshot.data[i]['name_joueur_one'],
                            joueurtow: snapshot.data[i]['name_joueur_tow'],
                            scoreone: snapshot.data[i]['score_one'],
                            scoretow: snapshot.data[i]['score_tow'],
                            clubone: snapshot.data[i]['club_one'],
                            clubtow: snapshot.data[i]['club_tow'],
                            imageplayerone:
                                'http://10.0.2.2:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['imageone']}',
                            imageplayertow:
                                'http://10.0.2.2:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['imagetow']}',
                            competitionname: snapshot.data[i]['name_comp'],
                            date: snapshot.data[i]['date'],
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }
}

class MeMatchList extends StatelessWidget {
  final joueurone;
  final joueurtow;
  final clubone;
  final clubtow;
  final scoreone;
  final scoretow;
  final imageplayerone;
  final imageplayertow;
  final competitionname;
  final date;
  const MeMatchList(
      {Key key,
      this.joueurone,
      this.joueurtow,
      this.clubone,
      this.clubtow,
      this.scoreone,
      this.scoretow,
      this.imageplayerone,
      this.imageplayertow,
      this.competitionname,
      this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 5, left: 5, top: 20),
      height: 240,
      width: 100,
      child: Column(children: [
        Container(
          padding: EdgeInsets.only(left: 15),
          child: ListTile(
            title: Text(
              competitionname,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: Text(date),
          ),
        ),
        Card(
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
                    Text(
                      joueurone,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(clubone)
                  ],
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                scoreone,
                style: TextStyle(fontSize: 50),
              ),
              Text(
                " ",
                style: TextStyle(fontSize: 50),
              ),
              Text(
                ":",
                style: TextStyle(fontSize: 50),
              ),
              Text(
                " ",
                style: TextStyle(fontSize: 50),
              ),
              Text(
                scoretow,
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(imageplayertow),
                      radius: 30,
                    ),
                    Text(
                      joueurtow,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(clubtow)
                  ],
                ),
              ),
            ],
          ))),
        ),
      ]),
    );
  }
}
