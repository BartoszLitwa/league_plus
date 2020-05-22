import 'package:firebase_auth/firebase_auth.dart';
import 'package:league_plus/models/user.dart';
import 'package:league_plus/services/FireStore/database.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get user {
    return auth.onAuthStateChanged;
  }
  
  // Sign in Anony
  Future signInAnon() async {
    try {
      AuthResult result = await auth.signInAnonymously();

      DatabaseService.uid = result.user.uid;
      await DatabaseService.setUserData();

      return _userFromFirebaseUser(result.user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);

      DatabaseService.uid = result.user.uid;
      
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);

      // Create a new document for this user with his uid
      DatabaseService.uid = result.user.uid;
      await DatabaseService.setUserData();

      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await auth.signOut();
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
}