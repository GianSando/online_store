import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:online_store_tk/src/pages/home_page.dart';

class InicioPage extends StatefulWidget {
  final dynamic userData;
  const InicioPage({super.key, this.userData});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  MotionTabBarController? _motionTabBarController;
  dynamic userDatos;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: _currentIndex,
      length: 5,
      vsync: this,
    );
    _checkDataUser();
  }

  void _checkDataUser() {
    final idUser = widget.userData['id'].toString();
    //verificar la autenticacion del usuario con autenticacion de firebase
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.uid == idUser) {
      userDatos = widget.userData;
    } else {
      //verificar la autenticacion del usuario con autenticacion de firestore
      final userFirestore = FirebaseFirestore.instance.collection('users');
      userFirestore.doc(idUser).get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userDatos = documentSnapshot.data();
        }
      });
    }
    print("userDatos: $userDatos");
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(userData: userDatos),
      Container(color: Colors.green),
      Container(color: Colors.blue),
      Container(color: Colors.red),
      Container(color: Colors.yellow),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Dashboard",
        labels: const ["Dashboard", "Home", "Shop", "Profile", "Settings"],
        icons: const [
          Icons.dashboard,
          Icons.home,
          Icons.shop,
          Icons.people_alt,
          Icons.settings
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.blue[600],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue[900],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            _currentIndex = value;
            _motionTabBarController!.index = value;
          });
        },
      ),
    );
  }
}
