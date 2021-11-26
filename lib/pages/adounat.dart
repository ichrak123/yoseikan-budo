import 'package:flutter/material.dart';
import 'package:yoseikanbudo/component/complist.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yoseikanbudo/component/mydrawer.dart';

class Adounat extends StatefulWidget {
  final categoryname;
  final titlename;

  const Adounat({Key key, this.categoryname, this.titlename}) : super(key: key);

  @override
  _AdounatState createState() => _AdounatState();
}

class _AdounatState extends State<Adounat> {
  int _selectedIndex = 0;
  var listcomp = [
    {
      'name': 'ichrak jrad',
      'date': '12/12/2014',
      'poid': '-90 kg',
      'sexe': 'male',
      'lieu': 'sfax'
    },
    {
      'name': 'Najet aljane',
      'date': '12/12/1995',
      'poid': '50 kg',
      'sexe': 'female',
      'lieu': 'jerba'
    },
  ];
  Future getData() async {
    var url =
        "http://192.168.42.178:80/federationtunisienne/getcompetition.php";
    var data = {"cat": widget.categoryname};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.titlename,
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
              future: getData(),
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
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}
