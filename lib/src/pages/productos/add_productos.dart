import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_store_tk/src/screen.dart';
import 'package:provider/provider.dart';

class AddProductos extends StatefulWidget {
  final dynamic userData;
  const AddProductos({super.key, this.userData});
  @override
  _AddProductosState createState() => _AddProductosState();
}

class _AddProductosState extends State<AddProductos> {
  List<dynamic> categorias = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    final serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);
    serviceProvider.getCategorias().listen((cat) {
      setState(() {
        categorias = cat.docs.map((e) => e.data()).toList();
      });
      //print("Banners: $banners");
    });
  }

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
          'Agregar Productos',
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
                    height: 200,
                    width: 200,
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
                //lista de categorias
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      //filled: true,
                      //fillColor: AppColors.oscureColor,
                    ),
                    isExpanded: true,
                    value: selectedCategory,
                    items: categorias
                        .map<DropdownMenuItem<dynamic>>((dynamic value) {
                      return DropdownMenuItem<dynamic>(
                        value: value['nameCategory'],
                        child: Text(value['nameCategory']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value.toString();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ImputDecorationWidget(
                  hintText: "Nombre del producto",
                  labelText: "Nombre",
                  controller: serviceProvider.nameProductController,
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
                ImputDecorationWidget(
                  hintText: "Descripcion del producto",
                  labelText: "Descripcion",
                  controller: serviceProvider.descriptionProductController,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: AppColors.oscureColor,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese una descripcion';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ImputDecorationWidget(
                  hintText: "Precio del producto",
                  labelText: "Precio",
                  controller: serviceProvider.priceProductController,
                  keyboardType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: AppColors.oscureColor,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un precio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                //boton para agregar el banner
                isLoading
                    ? const CircularProgressWidget(
                        text: "Agregando producto...")
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ButtomDecorationWidget(
                          text: "Guardar Producto",
                          onPressed: () {
                            //validar el formulario
                            final isValid = serviceProvider
                                .formService.currentState!
                                .validate();
                            if (!isValid) {
                              return;
                            } else {
                              //agregar el banner
                              serviceProvider.addProductos(
                                imagen: image,
                                nameProduct:
                                    serviceProvider.nameProductController.text,
                                descriptionProduct: serviceProvider
                                    .descriptionProductController.text,
                                priceProduct:
                                    serviceProvider.priceProductController.text,
                                categoryProduct: selectedCategory.toString(),
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
