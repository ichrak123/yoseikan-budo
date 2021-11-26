import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GradeJoueur extends StatefulWidget {
  final username;
  const GradeJoueur({Key key, this.username}) : super(key: key);

  @override
  _GradeJoueurState createState() => _GradeJoueurState();
}

class _GradeJoueurState extends State<GradeJoueur> {
  Future getGrade() async {
    var url = "http://192.168.1.4:80/federationtunisienne/examenjoueur.php";
    var data = {"joueur": widget.username};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("examen de grade"),
          backgroundColor: Color(0xFF00ACC1),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 15),
          child: FutureBuilder(
              future: getGrade(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return Examen(
                        name: snapshot.data[i]['nomprenom'],
                        date: snapshot.data[i]['date'],
                        grade: snapshot.data[i]['grade'],
                        lieu: snapshot.data[i]['lieu'],
                        resultat: snapshot.data[i]['resultat'],
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}

class Examen extends StatelessWidget {
  final grade;
  final name;
  final date;
  final lieu;
  final resultat;
  const Examen(
      {Key key, this.grade, this.name, this.date, this.lieu, this.resultat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 15, left: 15),
        child: Column(
          children: [
            ListTile(
              title: Text(date),
              subtitle: Text(lieu),
            ),
            SizedBox(
              height: 10,
            ),
            Table(
                border: TableBorder
                    .all(), // Allows to add a border decoration around your table
                children: [
                  TableRow(children: [
                    Text(
                      'grade',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'joueur',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'resultat',
                      textAlign: TextAlign.center,
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      grade,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      resultat,
                      textAlign: TextAlign.center,
                    ),
                  ]),
                ]),
          ],
        ));
  }
}
