import 'package:flutter/material.dart';
import 'package:online_store_tk/src/pages/productos/productos_widget.dart';
import 'package:online_store_tk/src/pages/widgets/text_widget.dart';
import 'package:online_store_tk/src/screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final dynamic userData;
  const HomePage({super.key, this.userData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> banners = [];
  List<dynamic> categorias = [];
  List<dynamic> productos = [];

  @override
  void initState() {
    super.initState();
    final serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);
    serviceProvider.getBanners().listen((data) {
      setState(() {
        banners = data.docs.map((e) => e.data()).toList();
      });
      //print("Banners: $banners");
    });
    serviceProvider.getCategorias().listen((cat) {
      setState(() {
        categorias = cat.docs.map((e) => e.data()).toList();
      });
      //print("Banners: $banners");
    });

    serviceProvider.getProductosOne("Farmacias").listen((product) {
      setState(() {
        productos = product.docs.map((e) => e.data()).toList();
      });
      //print("Banners: $banners");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty || categorias.isEmpty || productos.isEmpty) {
      return const ShimerWidget();
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          SuperiorContainer(userData: widget.userData),
          //llamar al stream de banners
          const SizedBox(height: 20),
          CarruselSliderWidget(banners: banners),
          const SizedBox(height: 20),
          const TextWidget(text: "Categorias", fontSize: 20),
          //llamar al stream de categorias
          CategoriasWidget(categorias: categorias),
          const SizedBox(height: 20),
          const TextWidget(text: "Productos de Farmacia", fontSize: 20),
          //llamar al stream de productos
          ProductosWidget(productos: productos),
          const SizedBox(height: 20),
        ],
      ),
      floatingActionButton: FloactionButtomWidget(userData: widget.userData),
    );
  }
}
