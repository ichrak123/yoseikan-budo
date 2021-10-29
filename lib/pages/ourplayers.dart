import 'package:flutter/material.dart';
import 'package:yoseikanbudo/component/complist.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yoseikanbudo/component/joueurlist.dart';

class OurPlayers extends StatefulWidget {
  final clubname;

  const OurPlayers({
    Key key,
    this.clubname,
  }) : super(key: key);

  @override
  _OurPlayersState createState() => _OurPlayersState();
}

class _OurPlayersState extends State<OurPlayers> {
  Future nosjoueurs() async {
    var url = "http://192.168.1.4:80/federationtunisienne/nosjoueurs.php";
    var data = {"club": widget.clubname};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.clubname,
            style: TextStyle(
              color: Color(0xFF263238),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 15),
          child: FutureBuilder(
              future: nosjoueurs(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return JoueurList(
                        name: snapshot.data[i]['nomprenom'],
                        numlicence: snapshot.data[i]['numerolicence'],
                        phone: snapshot.data[i]['phone'],
                        poid: snapshot.data[i]['poid'],
                        email: snapshot.data[i]['email'],
                        category: snapshot.data[i]['categorie'],
                        avatarUrl:
                            'http://192.168.1.4:80/federationtunisienne/assets/uploads/files/${snapshot.data[i]['image']}',
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
