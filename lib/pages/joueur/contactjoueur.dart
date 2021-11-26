import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:yoseikanbudo/component/bottomnavbarjoueur.dart';

class Contactjoueur extends StatefulWidget {
  const Contactjoueur({Key key}) : super(key: key);

  @override
  _ContactjoueurState createState() => _ContactjoueurState();
}

class _ContactjoueurState extends State<Contactjoueur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarjoueur(),
      appBar: AppBar(
        backgroundColor: Color(0xFF00ACC1),
        title: Text("contact"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                launch(('tel://71904613'));
              },
              child: Container(
                child: Image.asset("assets/images/phone.JPG"),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () async => {
                await launch(
                    "https://www.facebook.com/FederationTunisienneDeYoseikanBudo/")
              },
              child: Container(
                child: Image.asset("assets/images/fb.JPG"),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () async => {await launch("mailto:ftyoseikan@gmail.com")},
              child: Container(
                child: Image.asset("assets/images/email.JPG"),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () async => {await launch("https://http://www.ft-yb.tn/")},
              child: Container(
                child: Image.asset("assets/images/website.JPG"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
