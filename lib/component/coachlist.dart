import 'package:flutter/material.dart';
import 'package:yoseikanbudo/pages/coachcontact.dart';
import 'package:yoseikanbudo/pages/profilecontact.dart';

class CoachList extends StatelessWidget {
  final String avatarUrlcoach;
  final String namecoach;

  final numlicencecoach;

  final phonecoach;
  final emailcoach;

  final adressecoach;
  final datenaissancecoach;
  final gradecoach;

  const CoachList({
    Key key,
    this.avatarUrlcoach,
    this.namecoach,
    this.numlicencecoach,
    this.phonecoach,
    this.emailcoach,
    this.adressecoach,
    this.datenaissancecoach,
    this.gradecoach,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return CoachContact(
              avatarurl_d: avatarUrlcoach,
              name_d: namecoach,
              numlicence_d: numlicencecoach,
              phone_d: phonecoach,
              email_d: emailcoach,
              adresse_d: adressecoach,
              datenaissance_d: datenaissancecoach,
              grade_d: gradecoach);
        }));
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 24.0,
          backgroundImage: NetworkImage(avatarUrlcoach),
        ),
        title: Row(
          children: <Widget>[
            Text(
              namecoach,
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
        subtitle: Text(gradecoach),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}
