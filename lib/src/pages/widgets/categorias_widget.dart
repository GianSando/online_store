import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_store_tk/src/pages/categorias/product_details_category.dart';

class CategoriasWidget extends StatelessWidget {
  final List<dynamic> categorias;
  const CategoriasWidget({super.key, required this.categorias});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductosDetailsCategory(
                                  categoria: categorias[index]['nameCategory'],
                                )));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImageWidget(
                      imageCategory: categorias[index]['imageCategory'],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  categorias[index]['nameCategory'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CachedNetworkImageWidget extends StatelessWidget {
    final String imageCategory;
  final double height;
  final double width;
  const CachedNetworkImageWidget({
    super.key,
    required this.imageCategory,
    this.height = 70,
    this.width = 70,
  });


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      imageUrl: imageCategory,
      cacheKey: imageCategory,
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
    );
  }
}
