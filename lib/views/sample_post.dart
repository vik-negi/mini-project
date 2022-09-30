import 'package:flutter/material.dart';

// this page has only the UI of that page
class SamplePost extends StatelessWidget {
  const SamplePost({super.key});

  @override
  Widget build(BuildContext context) {
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
                  children: const [
                    Text(
                      "Event Title",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Event Organizer name"),
                    SizedBox(height: 10),
                    Text(
                      "Friday, 30 September 2022 , 1:05AM",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Thursday, 31 September 2022 , 2:33AM",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
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
