import 'dart:convert';
import 'dart:io';
import 'package:evika/utils/colors.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  // Future<Map<dynamic, dynamic>?> createPost() async {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Post',
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontFamily: "LexendDeca",
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.secondaryColor,
      ),
      body: GetBuilder<PostVM>(builder: (vm) {
        return SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter Details',
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontFamily: "LexendDeca",
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Column(
                  children: [
                    Form(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            controller: vm.titleController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Title',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: vm.descriptionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Short Discription',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Card(
                            child: TextFormField(
                              controller: vm.eventDescriptionController,
                              maxLines: 10,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Event Long Description",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: vm.locationController,
                            decoration: const InputDecoration(
                              labelText: 'Location',
                            ),
                          ),
                          // ignore: prefer_const_constructors
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.timer),
                              TextButton(
                                onPressed: () {
                                  vm.selectDateTime(context, "start");
                                },
                                child: const Text('Select Date'),
                              ),
                            ],
                          ),
                          vm.startDateController.text != '' &&
                                  vm.startTimeController.text != ''
                              ? Text(
                                  "${vm.startDateController.text} ${vm.startTimeController.text}")
                              : const Text(''),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.timer),
                              TextButton(
                                onPressed: () {
                                  vm.selectDateTime(context, "end");
                                },
                                child: const Text('Select Event End Date'),
                              ),
                            ],
                          ),
                          vm.endDateController.text != '' &&
                                  vm.endTimeController.text != ''
                              ? Text(
                                  "${vm.endDateController.text} ${vm.endTimeController.text}")
                              : const Text(''),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              vm.pickImage();
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
                              // final XFile? video = await picker.pickVideo(
                              //   source: ImageSource.gallery,
                              // );
                              // if (video != null) {
                              //   print(video.path);
                              // }
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
                              // final FilePickerResult? file = await filePicker
                              //     .pickFiles(
                              //         type: FileType.custom,
                              //         allowedExtensions: ['pdf']);

                              // if (file != null) {
                              //   print(file.files.single.path);
                              // }
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
                          vm.file_path != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber,
                                  ),
                                  // width: Get.height - 100,
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  height: 250,
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        File(vm.file_path!),
                                        fit: BoxFit.cover,
                                        // width: Get.height - 100,
                                        height:
                                            MediaQuery.of(context).size.width -
                                                100,
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              vm.file_path = null;
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
                              print("tapped");
                              vm.createPost();
                            },
                            child: const Text('Create Post'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
