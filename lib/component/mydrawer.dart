import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoseikanbudo/pages/clubprofile.dart';
import 'package:yoseikanbudo/pages/home.dart';
import 'package:yoseikanbudo/pages/mesmatchs.dart';
import 'package:yoseikanbudo/pages/ourcoachs.dart';
import 'package:yoseikanbudo/pages/ourplayers.dart';
import 'package:yoseikanbudo/pages/unseenNotificationPage.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
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
          accountEmail: isSignIn
              ? Text(
                  nomclub != null ? nomclub : "",
                  style: TextStyle(fontSize: 17),
                )
              : Text(""),
          accountName: isSignIn
              ? Text(
                  clubresponsable != null ? clubresponsable : "",
                  style: TextStyle(fontSize: 17),
                )
              : Text(""),
          currentAccountPicture: CircleAvatar(
            backgroundImage: ExactAssetImage('assets/images/logo.jpg'),
          ),
          otherAccountsPictures: <Widget>[],
          onDetailsPressed: () {},
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/purple.jpg"),
                  fit: BoxFit.cover)),
        ),
        isSignIn
            ? ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(fontSize: 17),
                ),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ClubProfile()));
                },
              )
            : SizedBox(
                height: 0,
              ),
        Divider(),
        isSignIn
            ? ListTile(
                title: Text(
                  'logout',
                  style: TextStyle(fontSize: 17),
                ),
                leading: Icon(Icons.logout),
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.remove("username");
                  Navigator.of(context).pushNamed("login");
                },
              )
            : ListTile(
                title: Text(
                  'Login',
                  style: TextStyle(fontSize: 17),
                ),
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
