import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_store_tk/src/widgets/full_scrren.dart';

class ProductDetails extends StatelessWidget {
  final dynamic product;
  const ProductDetails({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['nameProduct']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullScreen(
                            image: product['imageProduct'],
                          )));
            },
            child: Hero(
              tag: product['imageProduct'],
              child: CachedNetworkImage(
                height: 400,
                width: 400,
                fit: BoxFit.cover,
                imageUrl: product['imageProduct'],
                placeholder: (context, url) =>
                    const Image(image: AssetImage('assets/gif/animc.gif')),
                errorWidget: (context, url, error) =>
                    const Image(image: AssetImage('assets/images/noimage.png')),
              ),
            ),
          ),
          Text("\$ ${product['priceProduct']}"),
          Text(product['descriptionProduct']),
        ],
      ),
    );
  }
}