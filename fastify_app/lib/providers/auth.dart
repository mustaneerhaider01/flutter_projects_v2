import 'package:fastify_app/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

const defaultProfileImageUrl =
    'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541';

class Auth with ChangeNotifier {
  AppUser? _user;
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  AppUser? get user {
    return _user;
  }

  void setAppUser(AppUser? user) {
    if (user == null) {
      _user = null;
    } else {
      _user = user;
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    String? pickedImage,
  }) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = AppUser(
        uid: credentials.user!.uid,
        email: credentials.user!.email!,
        name: username,
        image: pickedImage ?? defaultProfileImageUrl,
      );
      notifyListeners();
      credentials.user!.updateDisplayName(username);
      credentials.user!.updatePhotoURL(pickedImage ?? defaultProfileImageUrl);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<dynamic> signInWithGoogle() {
    return _googleSignIn.signIn();
  }

  Future<void> logout() {
    _user = null;
    return _firebaseAuth.signOut();
  }
}
