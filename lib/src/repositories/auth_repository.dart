import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  GoogleSignInAccount? _googleUser;

  Future<void> signInWithGoogle() async {
    try {
      _googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await _googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final User? currentUser = userCredential.user;
      if (currentUser != null) {
        addUser(currentUser);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String? getUserId() {
    return _googleUser!.id;
  }

  Future<void> addUser(User user) async {
    try {
      final userCollection = _firestore.collection('users');
      final userDoc = userCollection.doc(user.uid);
      final userSnapshot = await userDoc.get();

      if (!userSnapshot.exists) {
        userDoc.set({
          'createdAt': DateTime.now(),
          'userId': user.uid,
          'username': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
        });
      }
    } catch (e) {}
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
