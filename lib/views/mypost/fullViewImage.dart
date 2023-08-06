import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class FullViewImageCarousel extends StatelessWidget {
  final List<String> images;
  FullViewImageCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        // elevation: 1,
        title: Text(
          "Images: ${images.length}",
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.black87,
          width: Get.width,
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: Get.width / Get.height,
              initialPage: 0,
              onPageChanged: (index, reason) {},
              autoPlay: true,
              disableCenter: true,
              height: Get.height,
              viewportFraction: 1,
            ),
            items: images
                .map(
                  (e) => SizedBox(
                    width: Get.width,
                    child: Image.network(
                      e,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
