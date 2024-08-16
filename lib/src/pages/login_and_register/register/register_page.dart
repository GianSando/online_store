// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_store_tk/src/provider/auth_provider.dart';
import 'package:online_store_tk/src/provider/register_provider.dart';
import 'package:online_store_tk/src/services/push_notification.dart';
import 'package:online_store_tk/src/utils/app_colors.dart';
import 'package:online_store_tk/src/utils/showsnacbar.dart';
import 'package:online_store_tk/src/validators/validator.dart';
import 'package:online_store_tk/src/widgets/button_decoration_widget.dart';
import 'package:online_store_tk/src/widgets/circularprogress_widget.dart';
import 'package:online_store_tk/src/widgets/imput_decoration_widget.dart';
import 'package:online_store_tk/src/widgets/upload_image.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? image;
  static String? token;

  @override
  void initState() {
    super.initState();
    token = PushNotificationService.token;
  }

  //REGISTRAR USUARIO
  void submitRegister() async {
    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProviderP>(context, listen: false);
    if (authProvider.formKey.currentState!.validate()) {
      authProvider.setLoading(true);

      //verificar si el nombre de usuario ya existe
      final bool existUsername = await registerProvider
          .chekUserExist(authProvider.usernameController.text);
      if (existUsername) {
        authProvider.setLoading(false);
        showSnackbar(context, "El nombre de usuario ya existe");
        return;
      }

      //verificar si el email ya existe
      final bool existEmail = await registerProvider
          .chekEmailExist(authProvider.emailController.text);
      if (existEmail) {
        authProvider.setLoading(false);
        showSnackbar(context, "El email ya existe");
        return;
      }

      //validar que ingrese imagen de perfil
      if (image == null) {
        authProvider.setLoading(false);
        showSnackbar(context, "Ingrese una imagen de perfil");
        return;
      }

      //obtener la fecha y hora actual
      final now = DateTime.now();
      String formatedDate = DateFormat('dd/MM/yyyy').format(now);
      //ontener la fecha de nacimiento
      final birth = authProvider.birthController.text;
      //calcular la edad
      DateTime dateBirth = DateFormat('dd/MM/yyyy').parse(birth);
      int age = now.year - dateBirth.year;
      if (now.month < dateBirth.month ||
          (now.month == dateBirth.month && now.day < dateBirth.day)) {
        age--;
      }

      //registrar usuario
      try {
        await registerProvider.registerUser(
          username: authProvider.usernameController.text,
          email: authProvider.emailController.text,
          password: authProvider.passwordController.text,
          rol: "user",
          birth: authProvider.birthController.text,
          age: age.toString(),
          token: token!,
          createdAt: formatedDate,
          image: image,
          onError: (error) {
            showSnackbar(context, error);
          },
        );
        //enviar correo de verificacion
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        showSnackbar(context, "Revise su correo para verificar su cuenta");
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
        authProvider.setLoading(false);
      } on FirebaseAuthException catch (e) {
        showSnackbar(context, e.toString());
      } catch (e) {
        showSnackbar(context, e.toString());
      }
    } else {
      authProvider.setLoading(false);
    }
  }

//selecionar una imagen
  void selectedImage() async {
    image = await uploadImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderP>(context);
    final isLoading = authProvider.isLoading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.fondoColors,
        iconTheme: const IconThemeData(color: AppColors.text),
        centerTitle: true,
        title: const Text(
          'Register',
          style: TextStyle(
            color: AppColors.text,
          ),
        ),
      ),
      body: Form(
        key: authProvider.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    selectedImage();
                  },
                  child: image == null
                      ? const CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.oscureColor,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: AppColors.text,
                          ),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(image!),
                        ),
                ),
                const SizedBox(height: 20),
                ImputDecorationWidget(
                  hintText: "Nombre de usuario",
                  labelText: "Ingrese su nombre de usuario",
                  controller: authProvider.usernameController,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(Icons.person_outline),
                  validator: Validators.validateUsername,
                ),
                const SizedBox(height: 20),
                ImputDecorationWidget(
                  hintText: "user@example.com",
                  labelText: "Ingrese su email",
                  controller: authProvider.emailController,
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const Icon(Icons.email_outlined),
                  validator: Validators.emailValidator,
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
                const SizedBox(height: 20),
                getBirth(context, authProvider),
                const SizedBox(height: 30),
                isLoading
                    ? const CircularProgressWidget(text: "Registrando...")
                    : ButtomDecorationWidget(
                        text: "Registrarse",
                        onPressed: submitRegister,
                      ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿Ya tienes cuenta?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: const Text("Inicia Sesión",
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
    );
  }

  Widget getBirth(BuildContext context, AuthProviderP authProvider) {
    return ImputDecorationWidget(
        hintText: "dd/mm/yyyy",
        labelText: "Ingrese su fecha de nacimiento",
        controller: authProvider.birthController,
        keyboardType: TextInputType.datetime,
        suffixIcon: const Icon(Icons.calendar_today_outlined),
        validator: Validators.birthValidator,
        readOnly: true,
        onTap: () async {
          DateTime? pickedData = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: AppColors.fondoColors,
                    onPrimary: Colors.white,
                    surface: AppColors.text,
                    onSurface: Colors.black,
                  ),
                  dialogBackgroundColor: AppColors.fondoColors,
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all(AppColors.oscureColor),
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );
          if (pickedData != null) {
            final DateFormat formatter = DateFormat('dd/MM/yyyy');
            String formatedData = formatter.format(pickedData);
            setState(() {
              authProvider.birthController.text = formatedData;
            });
          }
        });
  }
}
