import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Licence extends StatefulWidget {
  const Licence({Key key}) : super(key: key);

  @override
  _LicenceState createState() => _LicenceState();
}

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          title: Text('demande envoyé'),
        );
      });
}

class _LicenceState extends State<Licence> {
  var id = "";
  var username = "none";
  var nomclub;
  File _file;
  int _selectedIndex = 0;
  File _filetow;

  TextEditingController nomprenom = new TextEditingController();
  TextEditingController adresse = new TextEditingController();
  TextEditingController datenaissance = new TextEditingController();
  TextEditingController genretext = new TextEditingController();
  TextEditingController poidtext = new TextEditingController();
  TextEditingController categorytext = new TextEditingController();
  TextEditingController gradetext = new TextEditingController();
  TextEditingController emailtext = new TextEditingController();
  TextEditingController phonetext = new TextEditingController();

  TextEditingController nomcoach = new TextEditingController();
  TextEditingController adressecoach = new TextEditingController();
  TextEditingController datenaissancecoach = new TextEditingController();

  TextEditingController gradetextcoach = new TextEditingController();
  TextEditingController emailtextcoach = new TextEditingController();
  TextEditingController phonetextcoach = new TextEditingController();

  Future pickerCamera() async {
    final myfile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(myfile.path);
    });
  }

  Future pickerCameratow() async {
    final myfiletow = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _filetow = File(myfiletow.path);
    });
  }

  Future addLicence() async {
    if (_file == null) return;
    String base64 = base64Encode(_file.readAsBytesSync());
    String base641 = base64Encode(_filetow.readAsBytesSync());

    String imagename = _file.path.split("/").last;
    String imagenameone = _filetow.path.split("/").last;

    var url = "http://192.168.1.4:80/federationtunisienne/addlicence.php";
    var data = {
      "nomprenom": nomprenom.text,
      "adresse": adresse.text,
      "datenaissance": datenaissance.text,
      "genre": genretext.text,
      "categorie": categorytext.text,
      "poid": poidtext.text,
      "grade": gradetext.text,
      "club": id,
      "email": emailtext.text,
      "imagename": imagename,
      "image641": base64,
      "image642": base641,
      "imagenameone": imagenameone,
      "phone": phonetext.text
    };
    var response = await http.post(url, body: data);
    print(response.body);
    return AlertDialog(content: Text("fichier envoyé"));
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      nomclub = preferences.getString("nom_club");
      id = preferences.getString("id_club");
    });
  }

  Future addLicencecoach() async {
    if (_file == null) return;
    String base64 = base64Encode(_file.readAsBytesSync());
    String base641 = base64Encode(_filetow.readAsBytesSync());

    String imagename = _file.path.split("/").last;
    String imagenameone = _filetow.path.split("/").last;

    var url = "http://192.168.1.4:80/federationtunisienne/addlicencecoach.php";
    var data = {
      "nomcoach": nomcoach.text,
      "adresse": adressecoach.text,
      "datenaissance": datenaissancecoach.text,
      "gradecoach": gradetextcoach.text,
      "nomclub": id,
      "email": emailtextcoach.text,
      "imagename": imagename,
      "image641": base64,
      "image642": base641,
      "imagenameone": imagenameone,
      "phone": phonetextcoach.text
    };
    var response = await http.post(url, body: data);
    print(response.body);
  }

  int _currentStep = 0;
  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF00ACC1),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(
                  child: Text(
                    "Joueur",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Tab(
                  child: Text(
                    "coach",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            title: Text("demande licence"),
          ),
          body: TabBarView(
            children: [
              Stepper(
                steps: _stepper(),
                physics: ClampingScrollPhysics(),
                currentStep: this._currentStep,
                onStepTapped: (step) {
                  setState(() {
                    this._currentStep = step;
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (this._currentStep < this._stepper().length - 1) {
                      this._currentStep = this._currentStep + 1;
                    } else {
                      addLicence().whenComplete(() => showLoading(context));
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (this._currentStep > 0) {
                      this._currentStep = this._currentStep - 1;
                    } else {
                      this._currentStep = 0;
                    }
                  });
                },
              ),
              Stepper(
                steps: _steppertow(),
                physics: ClampingScrollPhysics(),
                currentStep: this._currentStep,
                onStepTapped: (step) {
                  setState(() {
                    this._currentStep = step;
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (this._currentStep < this._stepper().length - 1) {
                      this._currentStep = this._currentStep + 1;
                    } else {
                      addLicencecoach();
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (this._currentStep > 0) {
                      this._currentStep = this._currentStep - 1;
                    } else {
                      this._currentStep = 0;
                    }
                  });
                },
              ),
            ],
          )),
    );
  }

  List<Step> _stepper() {
    List<Step> _steps = [
      Step(
          title:
              Text("information personnelle", style: TextStyle(fontSize: 20)),
          content: Column(
            children: [
              TextFormField(
                controller: nomprenom,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    hintText: "Nom et prénom",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: adresse,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    hintText: "Adresse",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: datenaissance,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    labelText: "date de naissance",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: emailtext,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    labelText: "email",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: phonetext,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    labelText: "phone",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20))),
              ),
            ],
          ),
          isActive: _currentStep >= 0,
          state: StepState.complete),
      Step(
          title: Text("information sportif", style: TextStyle(fontSize: 20)),
          content: Column(
            children: [
              DropDownField(
                controller: genretext,
                hintText: "choisir genre",
                enabled: true,
                itemsVisibleInDropdown: 5,
                items: genre,
                onValueChanged: (value) {
                  setState(() {
                    selectgrenre = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              DropDownField(
                controller: categorytext,
                hintText: "choisir category",
                enabled: true,
                items: category,
                itemsVisibleInDropdown: 5,
                onValueChanged: (value) {
                  setState(() {
                    selectcategory = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              DropDownField(
                controller: poidtext,
                hintText: "choisir poid",
                enabled: true,
                itemsVisibleInDropdown: 5,
                items: poid,
                onValueChanged: (value) {
                  setState(() {
                    selectpoid = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              DropDownField(
                controller: gradetext,
                hintText: "choisir grade",
                enabled: true,
                itemsVisibleInDropdown: 5,
                items: grade,
                onValueChanged: (value) {
                  setState(() {
                    selectgrade = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
          isActive: _currentStep >= 2,
          state: StepState.complete),
      Step(
          title: Text("Documents", style: TextStyle(fontSize: 20)),
          content: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                          width: 2.0,
                          color: Colors.cyan[400],
                        )),
                    onPressed: pickerCamera,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_file,
                          color: Colors.cyan[400],
                        ),
                        Text("Télécharger de l'appariel",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.cyan[400],
                            )),
                      ],
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                          width: 2.0,
                          color: Colors.cyan[400],
                        )),
                    onPressed: pickerCameratow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.cyan[400],
                        ),
                        SizedBox(width: 10),
                        Text("Télécharger une photo",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.cyan[400],
                            )),
                      ],
                    )),
              ),
            ],
          ),
          isActive: _currentStep >= 3,
          state: StepState.complete),
    ];
    return _steps;
  }

  List<Step> _steppertow() {
    List<Step> _steps = [
      Step(
          title:
              Text("information personnelle", style: TextStyle(fontSize: 20)),
          content: Column(
            children: [
              TextFormField(
                controller: nomcoach,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    hintText: "Nom et prénom",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: adressecoach,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    hintText: "Adresse",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: datenaissancecoach,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    labelText: "date de naissance",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: emailtextcoach,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    labelText: "email",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: phonetextcoach,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    labelText: "phone",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20))),
              ),
            ],
          ),
          isActive: _currentStep >= 0,
          state: StepState.complete),
      Step(
          title: Text("information sportif", style: TextStyle(fontSize: 20)),
          content: Column(
            children: [
              DropDownField(
                controller: gradetextcoach,
                hintText: "choisir grade",
                enabled: true,
                itemsVisibleInDropdown: 5,
                items: grade,
                onValueChanged: (value) {
                  setState(() {
                    selectgrade = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
          isActive: _currentStep >= 2,
          state: StepState.complete),
      Step(
          title: Text("Documents", style: TextStyle(fontSize: 20)),
          content: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                          width: 2.0,
                          color: Colors.cyan[400],
                        )),
                    onPressed: pickerCamera,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_file,
                          color: Colors.cyan[400],
                        ),
                        Text("Télécharger de l'appariel",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.cyan[400],
                            )),
                      ],
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                          width: 2.0,
                          color: Colors.cyan[400],
                        )),
                    onPressed: pickerCameratow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.cyan[400],
                        ),
                        SizedBox(width: 10),
                        Text("Télécharger une photo",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.cyan[400],
                            )),
                      ],
                    )),
              ),
            ],
          ),
          isActive: _currentStep >= 3,
          state: StepState.complete),
    ];
    return _steps;
  }
}

String selectgrenre = "";
String selectpoid = "";
String selectcategory = "";
String selectgrade = "";
List<String> genre = ["femme", "homme"];
List<String> poid = [
  "-50kg",
  "-60kg",
  "-65kg",
  "-70kg ",
  "-75kg ",
  "-80kg ",
  "+80kg",
];
List<String> category = ["enfant", "adolecant", "junior", "senior"];
List<String> grade = [
  "1er kyu ",
  "2e kyu ",
  "3e kyu",
  "4e kyu",
  "5e kyu",
  "6e Kyu",
  "7eKyu",
  "8e Kyu",
  "9e Kyu",
  "1er dan",
  "2e dan",
  "3e dan"
];
