import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:yoseikanbudo/pages/joueur/Mesmatchjoueur.dart';
import 'dart:convert';

import 'package:yoseikanbudo/pages/mesmatchs.dart';

// ignore: camel_case_types
class unseenNotificationPagejoueur extends StatefulWidget {
  final usename;
  const unseenNotificationPagejoueur({Key key, this.usename}) : super(key: key);

  @override
  _unseenNotificationPagejoueurState createState() =>
      _unseenNotificationPagejoueurState();
}

// ignore: camel_case_types
class _unseenNotificationPagejoueurState
    extends State<unseenNotificationPagejoueur> {
  var username;
  var club;
  var id;
  var nomprenom;
  var image;

  bool isSignIn = false;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");
    club = preferences.getString("club");
    id = preferences.getString("joueur_id");
    nomprenom = preferences.getString("nomprenom");
    image = preferences.getString("image");

    if (username != null) {
      setState(() {
        username = preferences.getString("username");
        id = preferences.getString("joueur_id");
        club = preferences.getString("club");
        nomprenom = preferences.getString("nomprenom");
        image = preferences.getString("image");

        isSignIn = true;
      });
    }
  }

  List allUnseenNotification = [];
  Future getUnseenNotificationjoueur() async {
    var data = {"clubname": widget.usename, "clubnametow": widget.usename};
    var url =
        "http://192.168.1.4:80/federationtunisienne/selectunseennotificationjoueur.php";
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        allUnseenNotification = jsonData;
      });
    }
    print(allUnseenNotification);
  }

  Future updateNotification(String id) async {
    var url =
        "http://192.168.1.4:80/federationtunisienne/updateNtificationseen.php";
    var response = await http.post(url, body: {"id_combat": id});
    if (response.statusCode == 200) {
      print("ok");
    }
  }

  @override
  void initState() {
    super.initState();
    getUnseenNotificationjoueur();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("notification"),
          backgroundColor: Color(0xFF00ACC1),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView.builder(
              itemCount: allUnseenNotification.length,
              itemBuilder: (context, i) {
                var list = allUnseenNotification[i];
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MesMatchsJoueur(
                                    username: id,
                                  )));
                      updateNotification(list['id_combat'])
                          .whenComplete(() => getUnseenNotificationjoueur());
                    },
                    child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Vous avez un match : "),
                            Text(list['lieu']),
                          ],
                        ),
                        subtitle: Text(list['date']),
                        trailing: Text("detail")),
                  ),
                );
              },
            )));
  }
}
