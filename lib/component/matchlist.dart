import 'package:flutter/material.dart';
import 'package:yoseikanbudo/pages/matches.dart';
import 'package:yoseikanbudo/pages/rankingclub.dart';
import 'package:yoseikanbudo/pages/teste.dart';

class MatchList extends StatelessWidget {
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

  const MatchList({
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
            " ",
          ),
          subtitle: Row(
            children: [
              Text(groupe),
              SizedBox(
                width: 10,
              ),
              Text(" ")
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
              margin: EdgeInsets.only(top: 1, right: 10, left: 10),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(imageplayerone),
                          radius: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(joueurone),
                            Text("(AKA)"),
                          ],
                        ),
                        Text(clubone)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text(scoreone),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      child: Column(
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
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Text(scoretow),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(imageplayertow),
                          radius: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(joueurtow),
                            Text("(OA)"),
                          ],
                        ),
                        Text(clubtowtow)
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ],
    ));
  }
}
