import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_store_tk/src/screen.dart';
import 'package:provider/provider.dart';

class AddCategoriasPage extends StatefulWidget {
  final dynamic userData;
  const AddCategoriasPage({super.key, this.userData});
  @override
  _AddCategoriasPageState createState() => _AddCategoriasPageState();
}

class _AddCategoriasPageState extends State<AddCategoriasPage> {
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
          'Agregar Categoria',
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
                    width: 120,
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
                  'Recomendacion: Subir imagenes de 1080x1080',
                  style: TextStyle(
                    color: AppColors.oscureColor,
                    fontFamily: "MonM",
                  ),
                ),
                const SizedBox(height: 20),
                ImputDecorationWidget(
                  hintText: "Nombre de la categoria",
                  labelText: "Nombre",
                  controller: serviceProvider.namecategoryController,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: AppColors.oscureColor,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                //boton para agregar el banner
                isLoading
                    ? const CircularProgressWidget(
                        text: "Agregando categoria...")
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ButtomDecorationWidget(
                          text: "Guardar Categoria",
                          onPressed: () {
                            //validar el formulario
                            final isValid = serviceProvider
                                .formService.currentState!
                                .validate();
                            if (!isValid) {
                              return;
                            } else {
                              //agregar el banner
                              serviceProvider.addCategory(
                                imagen: image,
                                namecategory:
                                    serviceProvider.namecategoryController.text,
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
