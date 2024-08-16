import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

enum UserRole { admin, user, superAdmin }

class RegisterProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;



  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    required String rol,
    required String birth,
    required String age,
    required String token,
    required String createdAt,
    required File? image,
    //required Function onSuccess,
    required Function(String) onError,
  }) async {
    try {
      //convertir el username a minusculas
      final String usernameLowerCase = username.toLowerCase();

      //verificar si el usuario ya existe en la base de datos
      final bool userExist = await chekUserExist(usernameLowerCase);
      if (userExist) {
        onError('El usuario ya existe');
        return;
      }

      //verificar las credenciales del usuario
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = userCredential.user!;
      final String userId = user.uid;

      //subir la imagen al storage
      String imageUrl = '';
      if (image != null) {
        String direction = 'users/$username/$userId.jpg';
        imageUrl = await uploadImage(direction, image);
      }

      //guardar los datos del usuario en la base de datos
      final userDatos = {
        'id': userId,
        'username': username,
        'username_lowercase': usernameLowerCase,
        'password': password,
        'email': email,
        'rol': rol,
        'birth': birth,
        'edad': age,
        'token': token,
        'image': imageUrl,
        'createdAt': createdAt,
      };

      await _firestore.collection('users').doc(userId).set(userDatos);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('La contraseña es muy débil');
      } else if (e.code == 'email-already-in-use') {
        onError('El email ya está en uso');
      } else {
        onError(e.toString());
      }
    } catch (e) {
      onError('Error al registrar el usuario');
    }
  }

  //metodo para verificar si el usuario ya existe en la base de datos
  Future<bool> chekUserExist(String username) async {
    final QuerySnapshot result = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  //metodo para verificar si el email ya existe en la base de datos
  Future<bool> chekEmailExist(String email) async {
    final QuerySnapshot result = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  //metodo para guardar la imagen en el storage y obtener la url
  Future<String> uploadImage(String ref, File file) async {
    final UploadTask uploadTask = _storage.ref().child(ref).putFile(file);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
