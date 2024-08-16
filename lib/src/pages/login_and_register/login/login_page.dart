import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_store_tk/src/pages/inicio_page.dart';
import 'package:online_store_tk/src/provider/auth_provider.dart';
import 'package:online_store_tk/src/provider/login_provider.dart';
import 'package:online_store_tk/src/services/push_notification.dart';
import 'package:online_store_tk/src/utils/app_colors.dart';
import 'package:online_store_tk/src/utils/showsnacbar.dart';
import 'package:online_store_tk/src/validators/validator.dart';
import 'package:online_store_tk/src/widgets/button_decoration_widget.dart';
import 'package:online_store_tk/src/widgets/circularprogress_widget.dart';
import 'package:online_store_tk/src/widgets/imput_decoration_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static String? token;

  @override
  void initState() {
    super.initState();
    token = PushNotificationService.token;
  }

  //logearse
  void onFormLogin(
    String usernameOrEmail,
    String password,
    context,
  ) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProviderP>(context, listen: false);
    //ocultar teclado
    FocusScope.of(context).unfocus();

    if (authProvider.formKey.currentState!.validate()) {
      authProvider.setLoading(true);

      final String usernameOrEmailLower = usernameOrEmail.toLowerCase();

      loginProvider.loginUser(
        usernameOrEmail: usernameOrEmailLower,
        password: password,
        onSuccess: () async {
          //verificar si el usuario ha verificado su correo electronico
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null && user.emailVerified) {
            //si el usuario ha verificado su correo electronico
            authProvider.setLoading(false);
            dynamic userData = await loginProvider.getUserData(user.email!);

            //actualizar el token en la colleccion users
            await loginProvider.updateToken(token!, user.email!);

            //cambiar estado de autenticacion
            //loginProvider.checkAuthState();

            //navegar al inicio
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return InicioPage(
                userData: userData,
              );
            }));
          } else {
            //si el usuario no ha verificado su correo electronico
            authProvider.setLoading(false);
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Verifica tu correo"),
                  content: const Text(
                      "Por favor verifica tu correo electrónico para continuar"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Aceptar"),
                    ),
                  ],
                );
              },
            );
          }
        },
        onError: (String error) {
          authProvider.setLoading(false);
          showSnackbar(context, error.toString());
        },
      );
    } else {
      authProvider.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderP>(context);
    final isLoading = authProvider.isLoading;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: AppColors.greenOscure,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: const Center(
              child: Text(
                'Login',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: authProvider.formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ImputDecorationWidget(
                      hintText: "user@example.com",
                      labelText: "Ingrese su correo o email",
                      controller: authProvider.userOrEmailController,
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: const Icon(Icons.email_outlined),
                      validator: Validators.emailOrUser,
                    ),
                    const SizedBox(height: 20),
                    ImputDecorationWidget(
                      hintText: "********",
                      labelText: "Ingrese su contraseña",
                      controller: authProvider.passwordController,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          authProvider.obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          authProvider.setObscureText();
                        },
                      ),
                      obscureText: authProvider.obscureText,
                      validator: Validators.passwordValidator,
                    ),
                    const SizedBox(height: 30),
                    isLoading
                        ? const CircularProgressWidget(text: "Validando...")
                        : ButtomDecorationWidget(
                            text: "Inicia Sesión",
                            onPressed: () {
                              onFormLogin(
                                authProvider.userOrEmailController.text,
                                authProvider.passwordController.text,
                                context,
                              );
                            },
                          ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("¿No tienes cuenta?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/register");
                          },
                          child: const Text("Registrate",
                              style: TextStyle(
                                color: AppColors.oscureColor,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
