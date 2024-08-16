import 'package:flutter/material.dart';
import 'package:online_store_tk/src/screen.dart';

class AdminPage extends StatelessWidget {
  final dynamic userData;
  const AdminPage({super.key, this.userData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.text),
        backgroundColor: AppColors.oscureColor,
        title: const Text(
          'Admin Page',
          style: TextStyle(
            color: AppColors.text,
            fontFamily: "MonB",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 30),
              ButtomDecorationWidget(
                text: "Agregar banner",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddBannerPage(userData: userData)));
                },
              ),
              const SizedBox(height: 30),
              ButtomDecorationWidget(
                text: "Agregar categorias",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddCategoriasPage(userData: userData)));
                },
              ),
              const SizedBox(height: 30),
              ButtomDecorationWidget(
                text: "Agregar productos",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddProductos(userData: userData)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
