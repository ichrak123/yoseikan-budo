import 'package:flutter/material.dart';
import 'package:yoseikanbudo/pages/clubprofile.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClubProfile()));
            },
            child: Column(
              children: [
                IconButton(
                  color: Colors.grey,
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                Text(
                  "competition",
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                color: Colors.grey,
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              Text(
                "competition",
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                color: Colors.grey,
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              Text(
                "competition",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
