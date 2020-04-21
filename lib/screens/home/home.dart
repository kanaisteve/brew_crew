import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauth/models/brew.dart';
import 'package:firebaseauth/screens/home/brew_list.dart';
import 'package:firebaseauth/screens/home/settings_form.dart';
import 'package:firebaseauth/services/auth.dart';
import 'package:firebaseauth/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //create an _auth object that can be used to sign a user out
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(context: (context), builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            FlatButton.icon(
              onPressed: (){
                _auth.singOut();
              },
              icon: Icon(Icons.power_settings_new, color: Colors.white),
              label: Text('logout',  style: TextStyle(color: Colors.white)),
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings, color: Colors.white),
              label: Text('settings', style: TextStyle(color: Colors.white)),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              )
            ),
            child: BrewList()
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink[400],
          onPressed: () async {_showSettingsPanel();},
          tooltip: 'Increment',
          child: Icon(Icons.edit),
        ),
      ),
    );
  }
}