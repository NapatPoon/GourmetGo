import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> registration({
    required String email,
    required String name,
    required String password,
    required String confirmedPassword,
  }) async {
    try {
      // Check if passwords match
      if (password != confirmedPassword) {
        return 'Passwords do not match.';
      }

      // Create user with email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Update display name
        await user.updateDisplayName(name);

        // Store user data in Firestore
        await _storeUserData(user.uid, name, email);
      }

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> _storeUserData(String uid, String name, String email) async {
    try {
      // Store user data in Firestore
      await _firestore.collection('user').doc(uid).set({
        'name': name,
        'email': email,
      });
    } catch (e) {
      print('Error storing user data: $e');
    }
  }
}
