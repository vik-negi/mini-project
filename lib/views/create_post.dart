import 'dart:convert';
import 'dart:io';

import 'package:evika/repositories/post_repo/post_repo_imp.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart'
    as multipart;

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final ImagePicker picker = ImagePicker();
  FilePicker filePicker = FilePicker.platform;
  String? file_path = null;

  String? dateTime;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  DateTime? userSelectedDate;
  TimeOfDay? userSelectedTime;
  XFile? selectedImage;

  TextEditingController startDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();

  PostRepoImp postRepoImp = PostRepoImp();

  Future<Map<dynamic, dynamic>?> createPost() async {
    Map<String, dynamic> data;
    if (selectedImage != null) {
      final imageBytes = File(selectedImage!.path).readAsBytesSync();
      // ignore: prefer_interpolation_to_compose_strings
      String base64Image = base64Encode(imageBytes);
      data = {
        'title': titleController.text,
        'description': descriptionController.text,
        'eventStartAt':
            "${startTimeController.text} ${startDateController.text}",
        'eventEndAt': "${endTimeController.text} ${endDateController.text}",
        'location': locationController.text,
        "eventDescription": eventDescriptionController.text,
        'image': base64Image
      };
    } else {
      data = {
        'title': titleController.text,
        'description': descriptionController.text,
        'start_date': startDateController.text,
        'end_date': endDateController.text,
        'start_time': startTimeController.text,
        'end_time': endTimeController.text,
        'location': locationController.text,
        'image':
            'https://img.freepik.com/free-photo/grunge-paint-background_1409-1337.jpg?w=2000',
      };
    }
    print(data);
    Map<dynamic, dynamic>? response = await postRepoImp.createPost(data);
    print(response);
    if (response != null) {
      Get.snackbar('Success', 'Post Created Successfully');
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
    return {};
  }

  selectDateTime(context, String type) async {
    userSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2001),
      lastDate: DateTime(2100),
    );
    userSelectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (userSelectedDate != null) {
      if (type == 'start') {
        setState(() {
          startDateController.text =
              userSelectedDate!.toString().substring(0, 10);
        });
      } else {
        setState(() {
          endDateController.text =
              userSelectedDate!.toString().substring(0, 10);
        });
      }
    }
    if (userSelectedTime != null) {
      if (type == 'start') {
        setState(() {
          startTimeController.text =
              "${userSelectedTime!.hour}:${userSelectedTime!.minute}";
        });
      } else {
        setState(() {
          endTimeController.text =
              "${userSelectedTime!.hour}:${userSelectedTime!.minute}";
        });
      }
    }
    if (userSelectedDate != null && userSelectedTime != null) {
      setState(() {
        dateTime = '${selectedDate.toString().substring(0, 10)} $selectedTime';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Short Discription',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                            controller: eventDescriptionController,
                            maxLines: 10,
                            decoration: const InputDecoration.collapsed(
                              hintText: "Event Long  Description",
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer),
                        TextButton(
                          onPressed: () {
                            selectDateTime(context, "start");
                          },
                          child: const Text('Select Date'),
                        ),
                      ],
                    ),
                    startDateController.text != '' &&
                            startTimeController.text != ''
                        ? Text(
                            "${startDateController.text} ${startTimeController.text}")
                        : const Text(''),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer),
                        TextButton(
                          onPressed: () {
                            selectDateTime(context, "end");
                          },
                          child: const Text('Select Event End Date'),
                        ),
                      ],
                    ),
                    endDateController.text != '' && endTimeController.text != ''
                        ? Text(
                            "${endDateController.text} ${endTimeController.text}")
                        : const Text(''),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (image != null) {
                          setState(() {
                            file_path = image.path;
                            selectedImage = image;
                          });
                          // file_path = image.path;
                          // filePicker.saveFile(
                          //   fileName: "evika-image-${DateTime.now()}",
                          // );
                          print(image.path);
                        }
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.image,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add Image',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () async {
                        final XFile? video = await picker.pickVideo(
                          source: ImageSource.gallery,
                        );
                        if (video != null) {
                          print(video.path);
                        }
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.video_camera_back),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add Video to Post',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () async {
                        final FilePickerResult? file = await filePicker
                            .pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf']);

                        if (file != null) {
                          print(file.files.single.path);
                        }
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.file_copy),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add File to Post',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    file_path != null
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber,
                            ),
                            width: Get.height - 100,
                            height: 250,
                            child: Stack(
                              children: [
                                Image.file(
                                  File(file_path!),
                                  fit: BoxFit.cover,
                                  width: Get.height - 100,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        file_path = null;
                                      });
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    ElevatedButton(
                      onPressed: () async {
                        final data = await createPost();
                      },
                      child: const Text('Create Post'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
