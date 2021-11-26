import 'package:flutter/material.dart';
import 'package:yoseikanbudo/component/bottomnavbar.dart';

class About extends StatefulWidget {
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
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
