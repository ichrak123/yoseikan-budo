import 'package:flutter/material.dart';
import 'package:yoseikanbudo/pages/matches.dart';

class CompList extends StatelessWidget {
  final name;
  final date;
  final poid;
  final sexe;
  final id;

  const CompList({Key key, this.name, this.date, this.poid, this.sexe, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Matches(
                      competitionname: name,
                      competitionid: id,
                    )));
      },
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          margin: EdgeInsets.only(right: 15, left: 15),
          child: Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(name,
                    style: TextStyle(
                        color: Color(0xFF263238),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                subtitle: Row(
                  children: [
                    Text(
                      "Poid : ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF263238),
                      ),
                    ),
                    Text(poid, style: TextStyle(fontSize: 15))
                  ],
                ),
                trailing: Text(date),
              )
            ],
          ))),
    );
  }
}
