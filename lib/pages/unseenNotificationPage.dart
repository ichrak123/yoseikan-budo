import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yoseikanbudo/pages/mesmatchs.dart';

import 'login.dart';

// ignore: camel_case_types
class unseenNotificationPage extends StatefulWidget {
  final usename;
  const unseenNotificationPage({Key key, this.usename}) : super(key: key);

  @override
  _unseenNotificationPageState createState() => _unseenNotificationPageState();
}

// ignore: camel_case_types
class _unseenNotificationPageState extends State<unseenNotificationPage> {
  var username;
  var nomclub;
  var id;
  var clubresponsable;

  bool isSignIn = false;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");
    nomclub = preferences.getString("nom_club");
    id = preferences.getString("id_club");
    clubresponsable = preferences.getString("club_responsable");

    if (username != null) {
      setState(() {
        username = preferences.getString("username");
        id = preferences.getString("id_club");
        nomclub = preferences.getString("nom_club");
        clubresponsable = preferences.getString("club_responsable");

        isSignIn = true;
      });
    }
  }

  List allUnseenNotification = [];
  Future getUnseenNotification() async {
    var url =
        "http://192.168.1.4:80/federationtunisienne/selectunseennotification.php";
    var response = await http.get(
      url,
    );
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
    getUnseenNotification();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("notification")),
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
                              builder: (context) => MesMatchs(
                                    username: id,
                                  )));
                      updateNotification(list['id_combat'])
                          .whenComplete(() => getUnseenNotification());
                    },
                    child: ListTile(
                        title: Text(list['lieu']),
                        subtitle: Text(list['date']),
                        trailing: Text("detaille")),
                  ),
                );
              },
            )));
  }
}
