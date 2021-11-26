import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoseikanbudo/pages/joueur/Mesmatchjoueur.dart';
import 'package:yoseikanbudo/pages/joueur/joueurprofile.dart';

class DrawerMenujoueur extends StatefulWidget {
  const DrawerMenujoueur({Key key}) : super(key: key);

  @override
  _DrawerMenujoueurState createState() => _DrawerMenujoueurState();
}

class _DrawerMenujoueurState extends State<DrawerMenujoueur> {
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
        id = preferences.getString("licence_id");
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
    return Drawer(
      child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: isSignIn ? Text(club != null ? club : "") : Text(""),
          accountName:
              isSignIn ? Text(nomprenom != null ? nomprenom : "") : Text(""),
          currentAccountPicture: CircleAvatar(
            backgroundImage: ExactAssetImage('assets/images/logo.jpg'),
          ),
          otherAccountsPictures: <Widget>[
            CircleAvatar(
              child: Text('A'),
              backgroundColor: Colors.white60,
            ),
            CircleAvatar(
              child: Text('R'),
            ),
          ],
          onDetailsPressed: () {},
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/purple.jpg"),
                  fit: BoxFit.cover)),
        ),
        isSignIn
            ? ListTile(
                title: Text('Profile'),
                leading: Icon(Icons.person),
                onLongPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              JoueurProfile(name: nomprenom)));
                },
              )
            : SizedBox(
                height: 0,
              ),
        Divider(),
        isSignIn
            ? ListTile(
                title: Text('logout'),
                leading: Icon(Icons.logout),
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.remove("username");
                  Navigator.of(context).pushNamed("login");
                },
              )
            : ListTile(
                title: Text('Login'),
                leading: Icon(Icons.logout),
                onTap: () {
                  Navigator.of(context).pushNamed("login");
                },
              ),
        Divider(),
      ]),
    );
  }
}
