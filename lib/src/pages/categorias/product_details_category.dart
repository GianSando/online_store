import 'package:flutter/material.dart';
import 'package:online_store_tk/src/pages/productos/product_details.dart';
import 'package:online_store_tk/src/screen.dart';
import 'package:provider/provider.dart';

class ProductosDetailsCategory extends StatefulWidget {
  final String categoria;
  const ProductosDetailsCategory({super.key, required this.categoria});

  @override
  State<ProductosDetailsCategory> createState() =>
      _ProductosDetailsCategoryState();
}

class _ProductosDetailsCategoryState extends State<ProductosDetailsCategory> {
  List<dynamic> productos = [];

  @override
  void initState() {
    super.initState();
    final serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);
    serviceProvider.getProductosCategory(widget.categoria).listen((product) {
      setState(() {
        productos = product.docs.map((e) => e.data()).toList();
      });
      //print("Banners: $banners");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoria),
      ),
      body: GridView.builder(
        itemCount: productos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetails(
                              product: productos[index],
                            )));
              },
              child: Card(
                elevation: 10,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImageWidget(
                        height: double.infinity,
                        width: double.infinity,
                        imageCategory: productos[index]['imageProduct'],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productos[index]['nameProduct'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${productos[index]['priceProduct']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
