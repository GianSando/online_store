import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_store_tk/src/provider/register_provider.dart';
import 'package:online_store_tk/src/utils/showsnacbar.dart';
import 'package:provider/provider.dart';

class ServiceProvider extends ChangeNotifier {
  final formService = GlobalKey<FormState>();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController subtituloController = TextEditingController();
  final TextEditingController namecategoryController = TextEditingController();
  final TextEditingController nameProductController = TextEditingController();
  final TextEditingController descriptionProductController =
      TextEditingController();
  final TextEditingController priceProductController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //stream para leer la coleccion de banners de firebase
  Stream<QuerySnapshot> getBanners() {
    return FirebaseFirestore.instance
        .collection('banners')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  //stream para leer la coleccion de productos de firebase
  Stream<QuerySnapshot> getProductos() {
    return FirebaseFirestore.instance
        .collection('productos')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  //muestra productos especificos
    Stream<QuerySnapshot> getProductosOne(String nameCategory) {
    return FirebaseFirestore.instance
        .collection('productos')
        .where('categoryProduct', isEqualTo: nameCategory)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  //stream para leer la coleccion de categorias de firebase
  Stream<QuerySnapshot> getCategorias() {
    return FirebaseFirestore.instance
        .collection('categorias')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  //muestra los productos por categoria
  Stream<QuerySnapshot> getProductosCategory(String categorias) {
    return FirebaseFirestore.instance
        .collection('productos')
        .where('categoryProduct', isEqualTo: categorias)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  //metodo para agregar un banner a firebase
  Future<void> addBanner({
    required File? imagen,
    required String titulo,
    required String subtitulo,
    required dynamic userData,
    required BuildContext context,
  }) async {
    //cerrar el teclado
    FocusScope.of(context).unfocus();
    //agregar un loading
    setLoading(true);

    //verificar que ingrese una imagen
    if (imagen == null) {
      showSnackbar(context, 'Por favor ingrese una imagen');
      setLoading(false);
      return;
    }

    //tener la ref al provider de registro
    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    //tener la ref a la coleccion de banners
    final refBanner = FirebaseFirestore.instance.collection('banners');
    //id del documento
    final id = refBanner.doc().id;

    //subir la imagen al storage
    String imageUrl = '';
    if (imagen != null) {
      String direction = 'banners/$id.jpg';
      imageUrl = await registerProvider.uploadImage(direction, imagen);
    }

    try {
      //agregar el banner a la coleccion de banners
      await refBanner.doc(id).set({
        'id': id,
        'titulo': titulo,
        'subtitulo': subtitulo,
        'imageBanner': imageUrl,
        'createdAt': DateTime.now(),
        'userAdmin': userData['username'],
        'idUser': userData['id'],
        'imageUser': userData['image'],
      });

      //limpiar los controladores
      tituloController.clear();
      subtituloController.clear();

      //mostrar un mensaje de exito
      showSnackbar(context, 'Banner agregado correctamente');
      //quitar el loading
      setLoading(false);
      Navigator.pop(context);
    } catch (e) {
      //mostrar un mensaje de error
      showSnackbar(context, 'Error al agregar el banner');
      //quitar el loading
      setLoading(false);
      //print('Error al agregar el banner: $e');
    }
  }

  //metodo para eliminar un banner de firebase

  //metodo para agregar categorias a firebase
  Future<void> addCategory({
    required File? imagen,
    required String namecategory,
    required dynamic userData,
    required BuildContext context,
  }) async {
    //cerrar el teclado
    FocusScope.of(context).unfocus();
    //agregar un loading
    setLoading(true);

    //verificar que ingrese una imagen
    if (imagen == null) {
      showSnackbar(context, 'Por favor ingrese una imagen');
      setLoading(false);
      return;
    }

    //tener la ref al provider de registro
    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    //tener la ref a la coleccion de banners
    final refBanner = FirebaseFirestore.instance.collection('categorias');
    //id del documento
    final id = refBanner.doc().id;

    //subir la imagen al storage
    String imageUrl = '';
    if (imagen != null) {
      String direction = 'categorias/$id.jpg';
      imageUrl = await registerProvider.uploadImage(direction, imagen);
    }

    try {
      //agregar el banner a la coleccion de banners
      await refBanner.doc(id).set({
        'id': id,
        'nameCategory': namecategory,
        'imageCategory': imageUrl,
        'createdAt': DateTime.now(),
        'userAdmin': userData['username'],
        'idUser': userData['id'],
        'imageUser': userData['image'],
      });

      //limpiar los controladores
      namecategoryController.clear();

      //mostrar un mensaje de exito
      showSnackbar(context, 'Categoria agregado correctamente');
      //quitar el loading
      setLoading(false);
      Navigator.pop(context);
    } catch (e) {
      //mostrar un mensaje de error
      showSnackbar(context, 'Error al agregar el Categoria');
      //quitar el loading
      setLoading(false);
      //print('Error al agregar el banner: $e');
    }
  }

  //metodo para agregar productos a firebase
  //metodo para agregar categorias a firebase
  Future<void> addProductos({
    required File? imagen,
    required String nameProduct,
    required String descriptionProduct,
    required String priceProduct,
    required String categoryProduct,
    required dynamic userData,
    required BuildContext context,
  }) async {
    //cerrar el teclado
    FocusScope.of(context).unfocus();
    //agregar un loading
    setLoading(true);

    //verificar que ingrese una imagen
    if (imagen == null) {
      showSnackbar(context, 'Por favor ingrese una imagen');
      setLoading(false);
      return;
    }

    //tener la ref al provider de registro
    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    //tener la ref a la coleccion de banners
    final refBanner = FirebaseFirestore.instance.collection('productos');
    //id del documento
    final id = refBanner.doc().id;

    //subir la imagen al storage
    String imageUrl = '';
    if (imagen != null) {
      String direction = 'productos/$id.jpg';
      imageUrl = await registerProvider.uploadImage(direction, imagen);
    }

    try {
      //agregar el banner a la coleccion de banners
      await refBanner.doc(id).set({
        'id': id,
        'nameProduct': nameProduct,
        'descriptionProduct': descriptionProduct,
        'priceProduct': priceProduct,
        'categoryProduct': categoryProduct,
        'imageProduct': imageUrl,
        'createdAt': DateTime.now(),
        'userAdmin': userData['username'],
        'idUser': userData['id'],
        'imageUser': userData['image'],
      });

      //limpiar los controladores
      namecategoryController.clear();

      //mostrar un mensaje de exito
      showSnackbar(context, 'Producto agregado correctamente');
      //limpiar los controladores
      nameProductController.clear();
      descriptionProductController.clear();
      priceProductController.clear();

      //quitar el loading
      setLoading(false);
      Navigator.pop(context);
    } catch (e) {
      //mostrar un mensaje de error
      showSnackbar(context, 'Error al agregar un Producto');
      //quitar el loading
      setLoading(false);
      //print('Error al agregar el banner: $e');
    }
  }
}
