import 'package:flutter/material.dart';

import 'package:yoseikanbudo/component/bottomnavbarjoueur.dart';

class Aboutjoueur extends StatefulWidget {
  const Aboutjoueur({Key key}) : super(key: key);

  @override
  _AboutjoueurState createState() => _AboutjoueurState();
}

class _AboutjoueurState extends State<Aboutjoueur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarjoueur(),
      appBar: AppBar(
        backgroundColor: Color(0xFF00ACC1),
        title: Text("a propos de nous"),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 100),
          child: Image.asset("assets/images/cover.JPG")),
    );
  }
}
