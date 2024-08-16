import 'package:flutter/material.dart';

class AuthProviderP extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userOrEmailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  void setObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
}
