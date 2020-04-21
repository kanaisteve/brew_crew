import 'package:firebaseauth/models/brew.dart';
import 'package:firebaseauth/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

//    final brews = Provider.of<QuerySnapshot>(context);
//    print(brews.documents);
//    for(var doc in brews.documents){
//      print(doc.data);
//    }

//    final brews = Provider.of<List<Brew>>(context);
//    brews.forEach((brews){
//      print(brews.name);
//      print(brews.sugars);
//      print(brews.strength);
//    });

    final brews = Provider.of<List<Brew>>(context) ?? [];

    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) {
          return BrewTile(brew: brews[index]);}
    );
  }
}
