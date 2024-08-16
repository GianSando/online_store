import 'package:flutter/material.dart';
import 'package:online_store_tk/src/pages/firsh_page.dart';
import 'package:online_store_tk/src/pages/login_and_register/login/login_page.dart';
import 'package:online_store_tk/src/pages/login_and_register/register/register_page.dart';
import 'package:online_store_tk/src/pages/splash_page.dart';
import 'package:online_store_tk/src/routes/routes.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  Routes.splash: (_) => const SplashPage(),

  Routes.login: (_) => const LoginPage(),
  Routes.register: (_) => const RegisterPage(),

  Routes.firsh: (_) => const FirshPage(),

  //Routes.profile: (_) => const ProfilePage(),
  //Routes.settings: (_) => const SettingsPage(),
};
