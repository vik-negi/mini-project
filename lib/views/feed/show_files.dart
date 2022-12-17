import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShowFiles extends StatefulWidget {
  final String? file;
  final String tag;
  const ShowFiles({Key? key, this.file, required this.tag}) : super(key: key);

  @override
  State<ShowFiles> createState() => _ShowFilesState();
}

class _ShowFilesState extends State<ShowFiles> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (v) {
        // Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text('Show Files'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.download),
            ),
          ],
        ),
        body:
            // Hero(
            //   tag: widget.tag,
            //   child:
            Center(
                child: PhotoView(
          imageProvider: Image.network(widget.file!).image,
        )),
      ),
      // ),
    );
  }
}
