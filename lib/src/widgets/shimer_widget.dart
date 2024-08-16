import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimerWidget extends StatelessWidget {
  const ShimerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => ListTile(
            title: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 16.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            height: 16.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class ShimerWidget2 extends StatelessWidget {
  const ShimerWidget2({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        //shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 80,
            margin: const EdgeInsets.all(10),
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

class ShimerWidget3 extends StatelessWidget {
  const ShimerWidget3({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        //shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 120,
            margin: const EdgeInsets.all(10),
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimerWidget4 extends StatelessWidget {
  const ShimerWidget4({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        //shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 220,
            margin: const EdgeInsets.all(10),
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
