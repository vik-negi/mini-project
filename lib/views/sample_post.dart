import 'package:carousel_slider/carousel_slider.dart';
import 'package:evika/utils/widgets/post_container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// this page has only the UI of that page
class SamplePost extends StatelessWidget {
  const SamplePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample Post"),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, i) {
          return PostContainer();
        },
      ),
    );
  }
}
