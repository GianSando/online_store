import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarruselSliderWidget extends StatefulWidget {
  final List<dynamic> banners;
  const CarruselSliderWidget({super.key, required this.banners});

  @override
  State<CarruselSliderWidget> createState() => _CarruselSliderWidgetState();
}

class _CarruselSliderWidgetState extends State<CarruselSliderWidget> {
  //controlador de carrusel
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: 120,
            aspectRatio: 16 / 9,
            autoPlay: true,
            enableInfiniteScroll: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: widget.banners
              .map(
                (e) => CachedNetworkImage(
                  imageUrl: e['imageBanner'],
                  cacheKey: e['imageBanner'],
                  imageBuilder: (context, imageProvider) => Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e['titulo'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                e['subtitulo'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const Image(
                      image: AssetImage('assets/gif/anim.gif'),
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
                ),
              )
              .toList(),
        ),
        //animacion de puntos
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.banners.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: _current == entry.key ? 20.0 : 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      _current == entry.key ? Colors.blueAccent : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
