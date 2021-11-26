import 'package:flutter/material.dart';
import 'package:yoseikanbudo/pages/apropos.dart';
import 'package:yoseikanbudo/pages/contact.dart';
import 'package:yoseikanbudo/pages/home.dart';
import 'package:yoseikanbudo/pages/joueur/aproposjoueur.dart';
import 'package:yoseikanbudo/pages/joueur/contactjoueur.dart';
import 'package:yoseikanbudo/pages/joueur/homejoueur.dart';
import 'package:yoseikanbudo/pages/startpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBarjoueur extends StatefulWidget {
  const BottomNavBarjoueur({
    Key key,
  }) : super(key: key);

  @override
  _BottomNavBarjoueurState createState() => _BottomNavBarjoueurState();
}

class _BottomNavBarjoueurState extends State<BottomNavBarjoueur> {
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

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            title: "Acceuil",
            svgScr: "assets/images/hometow.png",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeJoueur(
                            usernameone: id,
                          )));
            },
          ),
          BottomNavItem(
            title: "A propos",
            svgScr: "assets/images/infotow.png",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Aboutjoueur()));
            },
          ),
          BottomNavItem(
            title: "Contact",
            svgScr: "assets/images/contacttow.png",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Contactjoueur()));
            },
            isActive: true,
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String svgScr;
  final String title;
  final Function press;
  final bool isActive;
  const BottomNavItem({
    Key key,
    this.svgScr,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset(
            svgScr,
            color: isActive ? Colors.orangeAccent : Colors.grey,
            height: 25,
            width: 25,
            fit: BoxFit.contain,
          ),
          Text(
            title,
            style:
                TextStyle(color: isActive ? Colors.orangeAccent : Colors.grey),
          ),
        ],
      ),
    );
  }
}
