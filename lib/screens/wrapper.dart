//flutter packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my imports
import 'package:firebaseauth/models/user.dart';
import 'package:firebaseauth/screens/authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    //return either Home or Authenticate.
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}