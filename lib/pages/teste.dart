import 'package:flutter/material.dart';
import 'package:yoseikanbudo/pages/home.dart';

import 'package:yoseikanbudo/pages/startpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'demandelicence.dart';

class Test extends StatefulWidget {
  final testname;
  const Test({
    Key key,
    this.testname,
  }) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
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

  int _selectedIndex = 0;
  final screens = [Homepage(), Welcome(), Licence()];
  @override
  void initState() {
    super.initState();
    getPref();
    Homepage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'A propos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contact',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
