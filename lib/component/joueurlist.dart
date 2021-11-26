import 'package:flutter/material.dart';
import 'package:yoseikanbudo/pages/profilecontact.dart';

class JoueurList extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String category;
  final numlicence;
  final poid;
  final phone;
  final email;
  final genre;
  final adresse;
  final datenaissance;
  final grade;

  const JoueurList(
      {Key key,
      this.avatarUrl,
      this.name,
      this.category,
      this.numlicence,
      this.poid,
      this.phone,
      this.email,
      this.genre,
      this.adresse,
      this.datenaissance,
      this.grade})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ProfileContact(
              avatarurl_d: avatarUrl,
              name_d: name,
              category_d: category,
              numlicence_d: numlicence,
              poid_d: poid,
              phone_d: phone,
              email_d: email,
              genre_d: genre,
              adresse_d: adresse,
              datenaissance_d: datenaissance,
              grade_d: grade);
        }));
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 24.0,
          backgroundImage: NetworkImage(avatarUrl),
        ),
        title: Row(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              width: 16.0,
            ),
            Text(
              " ",
            ),
          ],
        ),
        subtitle: Text(category),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}
