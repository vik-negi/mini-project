import 'dart:io';

import 'package:evika/utils/colors.dart';
import 'package:evika/utils/util_widgets_and_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';

class SelectedImageCrousel extends StatefulWidget {
  final List<XFile> selectedImages;
  int? imageNumber;

  SelectedImageCrousel(
      {super.key, required this.selectedImages, this.imageNumber});

  @override
  State<SelectedImageCrousel> createState() => _SelectedImageCrouselState();
}

class _SelectedImageCrouselState extends State<SelectedImageCrousel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  initialPage: widget.imageNumber ?? 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      widget.imageNumber = index;
                    });
                  },
                  enlargeCenterPage: true,
                  height: 400.0,
                  viewportFraction: 0.9,
                ),
                items: widget.selectedImages
                    .map(
                      (e) => InteractiveViewer(
                        child: SizedBox(
                          width: Get.width,
                          child: Image.file(
                            File(e.path),
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              UtilWidgetsAndFunctions.gapy(20),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text(
                  "${widget.imageNumber! + 1}/${widget.selectedImages.length}",
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
