import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_store_tk/src/pages/productos/product_details.dart';

class ProductosWidget extends StatelessWidget {
  final List<dynamic> productos;
  const ProductosWidget({super.key, required this.productos});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final product = productos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetails(product: product)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                  imageUrl: product['imageProduct'],
                  cacheKey: product['imageProduct'],
                  placeholder: (context, url) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const Image(
                      image: AssetImage('assets/gif/animc.gif'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  errorWidget: (context, url, error) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const Image(
                      image: AssetImage('assets/images/noimage.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  imageBuilder: (context, imageProvider) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: Text(
                              product['nameProduct'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
