import 'package:flutter/material.dart';
import 'package:yoseikanbudo/pages/joueur/loginjoueur.dart';
import 'package:yoseikanbudo/pages/login.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.black,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset('assets/images/logo.jpg',
                        height: 30, width: 30, fit: BoxFit.cover),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: ClipOval(
                          child: Container(
                            width: 180,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Text('Bienvenue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 40),
                      Text('Vous etes ?',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      SizedBox(height: 10),
                      Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogIn()));
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(width: 1.0)))),
                            child: Text(
                              'Responsable de club',
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginJoueur()));
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(width: 1.0)))),
                            child: Text(
                              'Joueur',
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(width: 1.0)))),
                            child: Text(
                              'Arbitre',
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(width: 1.0)))),
                            child: Text(
                              'Coach',
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
