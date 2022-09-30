import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// this page has only the UI of that page
class SamplePost extends StatelessWidget {
  const SamplePost({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = CarouselController();
    List<String> images = [
      "https://static.toiimg.com/thumb/msid-67840697,width-400,resizemode-4/67840697.jpg",
      "https://images.news18.com/ibnlive/uploads/2019/06/Turmeric-Festival-1.jpg?impolicy=website&width=0&height=0"
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Post'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Event Title",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("Event Organizer name"),
                    const SizedBox(height: 10),
                    const Text(
                      "Friday, 30 September 2022 , 1:05AM",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "Thursday, 31 September 2022 , 2:33AM",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    CarouselSlider(
                      items: images
                          .map((item) => Container(
                                child: Center(
                                    child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                  width: 1000,
                                )),
                              ))
                          .toList(),
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        aspectRatio: 2.0,
                        initialPage: 2,
                      ),
                    ),
                  ],
                ),
                // const ImageSlider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
