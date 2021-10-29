import 'package:flutter/material.dart';

class MobileDetails extends StatefulWidget {
  final groupe_d;
  final competition_d;
  final categorie_d;
  final joueurone_d;
  final joueurtow_d;
  final clubone_d;
  final clubtowtow_d;
  final scoreone_d;
  final scoretow_d;
  final resultat_d;
  final date_d;
  final typeresult_d;
  final imageplayertow_d;
  final imageplayerone_d;
  final score_d;
  final pt_d;
  final moy_d;
  final santion_d;
  final technique_d;
  final ptone_d;
  final moyone_d;
  final santionone_d;
  final lieu_d;
  final tourname_d;
  final arbitrename_d;

  const MobileDetails(
      {Key key,
      this.groupe_d,
      this.competition_d,
      this.categorie_d,
      this.joueurone_d,
      this.joueurtow_d,
      this.clubone_d,
      this.clubtowtow_d,
      this.scoreone_d,
      this.scoretow_d,
      this.resultat_d,
      this.date_d,
      this.typeresult_d,
      this.imageplayertow_d,
      this.imageplayerone_d,
      this.score_d,
      this.pt_d,
      this.moy_d,
      this.santion_d,
      this.technique_d,
      this.ptone_d,
      this.moyone_d,
      this.santionone_d,
      this.lieu_d,
      this.tourname_d,
      this.arbitrename_d})
      : super(key: key);

  @override
  _MobileDetailsState createState() => _MobileDetailsState();
}

class _MobileDetailsState extends State<MobileDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("details"),
        ),
        body: Container(
            child: Column(
          children: [
            ListTile(
              title: Text(
                widget.competition_d,
              ),
              subtitle: Row(
                children: [
                  Text(widget.groupe_d),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.tourname_d)
                ],
              ),
              trailing: Text(
                widget.date_d,
              ),
            ),
            Card(
                margin: EdgeInsets.only(top: 1, right: 10, left: 10),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.imageplayerone_d),
                            radius: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.joueurone_d),
                              Text("(AKA)"),
                            ],
                          ),
                          Text(widget.clubone_d)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(widget.scoreone_d),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Vainqueur : "),
                            Text(
                              widget.resultat_d,
                            )
                          ],
                        ),
                        Text(
                          widget.typeresult_d,
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Text(widget.scoretow_d),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.imageplayertow_d),
                            radius: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.joueurtow_d),
                              Text("(OA)"),
                            ],
                          ),
                          Text(widget.clubtowtow_d)
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 50,
            ),
            Container(
                margin: EdgeInsets.only(right: 15, left: 15),
                child: Column(
                  children: [
                    Text(
                      'les points de joueur rouge AKA',
                      textAlign: TextAlign.center,
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
                              'technique des poings et pieds',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Projection franche (cote , dot , face)',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Immobilisation arrivé de 10 seconde',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'sanction',
                              textAlign: TextAlign.center,
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              widget.technique_d,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.moy_d,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.pt_d,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.santion_d,
                              textAlign: TextAlign.center,
                            ),
                          ]),
                        ]),
                  ],
                )),
            SizedBox(
              height: 50,
            ),
            Container(
                margin: EdgeInsets.only(right: 15, left: 15),
                child: Column(
                  children: [
                    Text(
                      'les points de joueur bleu OA',
                      textAlign: TextAlign.center,
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
                              'technique des poings et pieds',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Projection franche (cote , dot , face)',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Immobilisation arrivé de 10 seconde',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'sanction',
                              textAlign: TextAlign.center,
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              widget.score_d,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.moyone_d,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.ptone_d,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.santionone_d,
                              textAlign: TextAlign.center,
                            ),
                          ]),
                        ]),
                  ],
                )),
          ],
        )));
  }
}
