// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:online_store_tk/src/pages/inicio_page.dart';
import 'package:online_store_tk/src/provider/login_provider.dart';
import 'package:online_store_tk/src/widgets/circularprogress_widget.dart';
import 'package:provider/provider.dart';

class FirshPage extends StatefulWidget {
  const FirshPage({super.key});
  @override
  _FirshPageState createState() => _FirshPageState();
}

class _FirshPageState extends State<FirshPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late bool isFirstTime;

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _checkAuthStatus();
  }

  Future<void> _initPrefs() async {
    final userBox = await Hive.openBox('user');
    isFirstTime = !userBox.containsKey('isLogged');
  }

  void _checkAuthStatus() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    await Future.delayed(const Duration(seconds: 1));
    if (isFirstTime) {
      final userBox = await Hive.openBox('user');
      userBox.put('isLogged', true);
      Navigator.pushReplacementNamed(context, '/splash');
    } else {
      final userBox = await Hive.openBox('user');
      final bool isLogged = userBox.get('isLogged', defaultValue: false);
      final user = _auth.currentUser;
      if (user != null && user.email != null && user.emailVerified) {
        dynamic userData = await loginProvider.getUserData(user.email!);

        if (isLogged) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InicioPage(userData: userData)));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InicioPage(userData: userData)));
        }
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressWidget(text: "Cargando..."),
      ),
    );
  }
}
