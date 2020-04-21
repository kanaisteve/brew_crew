import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/models/user.dart';
import 'package:firebaseauth/services/database.dart';

class AuthService {
  //the underscore in _auth means this ia a private property and can only be used in this file and not in other file
  //the _auth object will give us access to methods and properties of the FirebaaseAuth Class on this class.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on Firebase
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //1. sing in anon
  Future signInAnon() async {
    try{
      //_auth_signInAnonymously will return an AuthResult
      //on the result object we have access to a user object which represents that user.
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e) {
      print(e.toString());
      return null;
    }
  }
  
  //2. sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString);
      return null;
    } 
  } 

  //3. register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString);
      return null;
    }
  } 

  //4.sign out
  Future singOut() async {
    try {
      return await _auth.signOut();
    }catch (e) {
      print(e.toString());
      return null;
    }
  }
}