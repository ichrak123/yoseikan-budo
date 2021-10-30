import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoseikanbudo/component/mydrawer.dart';
import 'package:yoseikanbudo/pages/home.dart';
import 'package:yoseikanbudo/pages/teste.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content:
                Row(children: [Text('loading'), CircularProgressIndicator()]));
      });
}

showdialogall(context, String mytitle, String mycontent) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(mytitle),
          content: Text(mycontent),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('done'))
          ],
        );
      });
}

class _LogInState extends State<LogIn> {
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

  bool isLoading = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController usernamecontroller = new TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  savePref(
      String username,
      String id,
      String nombreentraineur,
      String nombrejoueur,
      String nomclub,
      String clubresponsable,
      String apropos,
      String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id_club", id);
    preferences.setString("nombreentraineur", nombreentraineur);
    preferences.setString("nombrejoueur", nombrejoueur);
    preferences.setString("nom_club", nomclub);
    preferences.setString("club_responsable", clubresponsable);
    preferences.setString("username", username);

    preferences.setString("apropos", apropos);
    preferences.setString("email", email);

    print(preferences.getString("username"));
    print(preferences.getString("id_club"));
    print(preferences.getString("nombreentraineur"));
    print(preferences.getString("nombrejoueur"));
    print(preferences.getString("email"));
    print(preferences.getString("apropos"));
  }

  String validglobal(String val) {
    if (val.isEmpty) {
      return "field is empty";
    }
  }

  String validusername(String val) {
    if (val.trim().isEmpty) {
      return "username is empty";
    }
  }

  String validpassword(String val) {
    if (val.trim().isEmpty) {
      return "password is empty";
    }
  }

  signin() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      formdata.save();
      setState(() {
        isLoading = true;
      });
      showLoading(context);
      var data = {
        "username": usernamecontroller.text,
        "password": passwordcontroller.text,
      };
      var url = "http://192.168.1.4:80/federationtunisienne/login.php";
      var response = await http.post(url, body: data);
      var responsebody = jsonDecode(response.body);

      if (responsebody['status'] == "sucsses") {
        showNotification();
        savePref(
          responsebody['username'],
          responsebody['id_club'],
          responsebody['nombreentraineur'],
          responsebody['nombrejoueur'],
          responsebody['nom_club'],
          responsebody['club_responsable'],
          responsebody['email'],
          responsebody['apropos'],
        );
        print(responsebody['username']);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Homepage(
                      usernameone: id,
                    )));
      } else {
        print("login failed");
        showdialogall(context, "wrong", "email or password wrong");
      }
    } else {
      print('not validate');
    }
  }

  bool hidePassword = true;
  void hidePass() {
    if (hidePassword) {
      setState(() {
        hidePassword = false;
      });
    } else {
      setState(() {
        hidePassword = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var initilize = InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initilize,
        onSelectNotification: onSelectNotification);
    getPref();
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint("Notification : " + payload);
    }
  }

  Future showNotification() async {
    var android = AndroidNotificationDetails(
        "channelId", "channek", "channelDescriptionss");
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android, ios);
    flutterLocalNotificationsPlugin.show(
        0, "Notifications", usernamecontroller.text, platform,
        payload: 'some detailes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                width: 90,
                height: 90,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Bienvenue",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "La féderation tunisienne de Yoseikan Budo",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 60,
              ),
              Form(
                key: formstate,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50)),
                        child: TextFormField(
                          controller: usernamecontroller,
                          validator: validusername,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: new Icon(
                                  Icons.supervised_user_circle_rounded),
                            ),
                            labelText: 'Login',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: TextFormField(
                          controller: passwordcontroller,
                          validator: validglobal,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              suffixIcon: IconButton(
                                icon: hidePassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                onPressed: hidePass,
                              ),
                              labelText: 'Mot de passe'),
                          obscureText: hidePassword ? true : false,
                        ),
                      ),
                      SizedBox(height: 30),
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              // ignore: deprecated_member_use
                              child: ElevatedButton(
                                onPressed: signin,
                                child: Text(
                                  "Continuer",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              )),
                        ),
                        SizedBox(height: 30),
                        Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              // ignore: deprecated_member_use
                            )),
                      ]),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
