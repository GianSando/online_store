// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_store_tk/src/screen.dart';
import 'package:provider/provider.dart';

class AddBannerPage extends StatefulWidget {
  final dynamic userData;
  const AddBannerPage({super.key, this.userData});
  @override
  _AddBannerPageState createState() => _AddBannerPageState();
}

class _AddBannerPageState extends State<AddBannerPage> {
  File? image;
  //selecionar una imagen
  void selectedImage() async {
    image = await uploadImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final isLoading = serviceProvider.isLoading;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.text),
        backgroundColor: AppColors.oscureColor,
        title: const Text(
          'Agregar Banners',
          style: TextStyle(
            color: AppColors.text,
            fontFamily: "MonB",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: serviceProvider.formService,
            child: Column(
              children: [
                const SizedBox(height: 30),
                //agregar la imagen
                GestureDetector(
                  onTap: selectedImage,
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.oscureColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: image == null
                        ? const Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: AppColors.text,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                //Recomendacion
                const Text(
                  'Recomendacion: Subir imagenes de 1920x780',
                  style: TextStyle(
                    color: AppColors.oscureColor,
                    fontFamily: "MonM",
                  ),
                ),
                const SizedBox(height: 20),
                ImputDecorationWidget(
                  hintText: "Titulo del banner",
                  labelText: "Titulo",
                  controller: serviceProvider.tituloController,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: AppColors.oscureColor,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un titulo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ImputDecorationWidget(
                  hintText: "Subtitulo del banner",
                  labelText: "Subtitulo",
                  controller: serviceProvider.subtituloController,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: AppColors.oscureColor,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un subtitulo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                //boton para agregar el banner
                isLoading
                    ? const CircularProgressWidget(text: "Agregando banner...")
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ButtomDecorationWidget(
                          text: "Guardar Banner",
                          onPressed: () {
                            //validar el formulario
                            final isValid = serviceProvider
                                .formService.currentState!
                                .validate();
                            if (!isValid) {
                              return;
                            } else {
                              //agregar el banner
                              serviceProvider.addBanner(
                                imagen: image,
                                titulo: serviceProvider.tituloController.text,
                                subtitulo:
                                    serviceProvider.subtituloController.text,
                                userData: widget.userData,
                                context: context,
                              );
                            }
                          },
                        ),
                      ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
