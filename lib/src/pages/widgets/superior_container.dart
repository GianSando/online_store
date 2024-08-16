import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_store_tk/src/utils/app_colors.dart';

class SuperiorContainer extends StatelessWidget {
  final dynamic userData;
  const SuperiorContainer({super.key, this.userData});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hola!!",
                style: TextStyle(fontFamily: "MonB", fontSize: 20),
              ),
              Text(
                userData['username'],
                style: const TextStyle(
                  fontFamily: "MonM",
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColors.greenAcents,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppColors.greenAcents,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: userData['image'],
                cacheKey: userData['image'],
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                placeholder: (context, url) => ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('assets/gif/circle.gif',
                      height: 50, width: 50),
                ),
                errorWidget: (context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/noimage.png',
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
