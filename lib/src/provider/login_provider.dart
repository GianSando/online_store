import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum AuthStatus { notAuthentication, chaeking, authenticated }

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthStatus authStatus = AuthStatus.notAuthentication;

  Future<void> loginUser({
    required String usernameOrEmail,
    required String password,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    try {
      authStatus = AuthStatus.chaeking;
      notifyListeners();

      //para el ingreso con username
      final String usernameOrEmailLowerCase = usernameOrEmail.toLowerCase();
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('username_lowercase', isEqualTo: usernameOrEmailLowerCase)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        final String email = result.docs.first.get('email');
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        onSuccess();
        return;
      }

      //para el ingreso con email
      final QuerySnapshot resultEmail = await _firestore
          .collection('users')
          .where('email', isEqualTo: usernameOrEmailLowerCase)
          .limit(1)
          .get();

      if (resultEmail.docs.isNotEmpty) {
        final String email = resultEmail.docs.first.get('email');
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        onSuccess();
        return;
      }

      onError('No se encontró el usuario o email ingresado.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        onError('Usuario o contraseña incorrecta.');
      } else {
        onError(e.toString());
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  //verificar el estado del usuario
  void checkAuthState() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        authStatus = AuthStatus.notAuthentication;
      } else {
        authStatus = AuthStatus.authenticated;
      }
      notifyListeners();
    });
  }

  //obtener datos del usuario
  Future<dynamic> getUserData(String email) async {
    final QuerySnapshot<Map<String, dynamic>> result = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (result.docs.isNotEmpty) {
      final userData = result.docs[0].data();
      return userData;
    }
    return null;
  }

  //actualizar el token del usuario
  Future<void> updateToken(String token, String email) async {
    final QuerySnapshot<Map<String, dynamic>> result = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (result.docs.isNotEmpty) {
      final String userId = result.docs[0].get('id');
      await _firestore.collection('users').doc(userId).update({'token': token});
    }
  }
}
