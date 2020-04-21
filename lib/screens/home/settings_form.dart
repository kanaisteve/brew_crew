import 'package:firebaseauth/models/user.dart';
import 'package:firebaseauth/services/database.dart';
import 'package:firebaseauth/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebaseauth/shared/constants.dart';
import 'package:provider/provider.dart';


class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context); // here we have access to the current user logged in and we can access the id from that user.

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData, // here we are listening to the stream inside that widget
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data; // userData is the data stored in the firestore database.
          return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>  val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars')
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),
                  //slider
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    inactiveColor: Colors.brown[_currentStrength ?? 100],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) => setState(() => _currentStrength = val.round()),
                  ),
                  //button
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text('Update', style: TextStyle(color: Colors.white)),
                    onPressed: () async{
                      if(_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength
                        );
                        Navigator.pop(context);
                      }
                      print(_currentName);
                      print(_currentSugars);
                      print(_currentStrength);
                    },
                  ),
                ],
              )
          );
        }else {
            return Loading();
        }

      }
    );
  }
}
