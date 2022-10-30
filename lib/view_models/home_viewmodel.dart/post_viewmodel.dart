import 'dart:convert';

import 'package:evika/data/remote/api_responce.dart';
import 'package:evika/data/remote/api_services/post_api_service.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:evika/repositories/post_repo/post_repo_imp.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostVM extends GetxController {
  ApiResponce<Map<dynamic, dynamic>?> response = ApiResponce.loading();
  PostData postData = PostData();
  List<PostData> postList = <PostData>[].obs;

  late final Future? futurePosts;
  RxBool isPostFetched = false.obs;
  RxBool isErrorOnFetchingData = false.obs;

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  // create post
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

  void pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      file_path = image.path;
      selectedImage = image;
      print(image.path);
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    futurePosts = getAllPost();
  }

  PostApiServices postApiServices = PostApiServices();

  Future<List<PostData>?> getAllPost() async {
    response = ApiResponce.loading();
    isErrorOnFetchingData(false);
    isPostFetched(false);
    update();
    Map<dynamic, dynamic>? data = await postRepoImp.getAllPost();
    print("ddddddddddd");
    print(data);

    try {
      if (data != null) {
        List<dynamic> list = data['data'];
        response = ApiResponce.completed(data);
        update();
        // postList = parsePhotos(postdata);
        postList = [];
        for (int i = 0; i < list.length; i++) {
          String postdataStr = jsonEncode(list[i]);
          PostData postData = PostData.fromJson(postdataStr);
<<<<<<< HEAD
          // postList.add(pop);
          // postData = PostData(
          //   createdAt: list[i]['createdAt'] as String?,
          //   description: list[i]['description'] as String?,
          //   eventCategory: list[i]['eventCategory'] as String?,
          //   eventEndAt: list[i]['eventEndAt'] as String?,
          // );
          debugPrint("aaaaaaaaaaaaaaaaaaa");
=======

>>>>>>> 05c0ceb568dbd2097dc3e71706c62f250909a253
          postList.add(postData);
          print("llllllllllllll");
          print(postList[i].eventId);
          isPostFetched.value = true;

          update();
        }
        debugPrint(postList.length.toString());

        return postList;
      } else {
        isPostFetched.value = false;
        isErrorOnFetchingData.value = true;
        response = ApiResponce.error("No data found");
        update();
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      isPostFetched.value = false;
      isErrorOnFetchingData.value = true;
      response = ApiResponce.error("No data found");
      update();
      return null;
    }
  }

  Future<void> createPost() async {
    if (titleController.text == "" || titleController.text == null) {
      Get.snackbar("Error", "Please enter title");
      return;
    }
    try {
      print("chala");
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      http.Response tagsMap =
          await http.post(Uri.parse("$mlBaseUrl/api/keywords"), body: {
        "text": descriptionController.text,
        "user_id": "1",
      });
      String tagString = "";
      List tagList = jsonDecode(tagsMap.body)["data"];
      jsonDecode(tagsMap.body)["data"].forEach((element) {
        tagString += "$element,";
      });
      tagString = tagString.substring(0, tagString.length - 1);
      var request = http.MultipartRequest(
          "POST", Uri.parse("$baseUrl/api/user/create-post/"));
      request.fields["title"] = titleController.text;
      request.fields["description"] = descriptionController.text;
      request.fields["location"] = locationController.text;
      request.fields["eventDescription"] = eventDescriptionController.text;
      request.fields["eventStartAt"] =
          '${startDateController.text} ${startTimeController.text}';

      request.fields["eventEndAt"] =
          '${endDateController.text} ${endTimeController.text}';
      request.fields["eventCategory"] = 'sports';
      request.fields["tags"] = tagString;
      request.fields["userId"] = sharedPreferences.getString("user_id")!;
      request.files
          .add(await http.MultipartFile.fromPath("image", selectedImage!.path));

      String? response = await postRepoImp.createPost(request);

      print(response);
      if (response != null) {
        Get.snackbar('Success', 'Post Created Successfully');
        print('Post Created Successfully');
      } else {
        Get.snackbar('Error', 'Something went wrong');
        print("something went wrong");
      }
    } catch (err) {
      print("err : $err");
    }
  }

  Future<bool?>? likePost(id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String user_id = sharedPreferences.getString("user_id")!;
    Map<String, dynamic>? response = await postRepoImp.likePost(id, user_id);
    if (response != null) {
      return true;
    } else {
      return false;
    }
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
        startDateController.text =
            userSelectedDate!.toString().substring(0, 10);
      } else {
        endDateController.text = userSelectedDate!.toString().substring(0, 10);
      }
    }
    if (userSelectedTime != null) {
      if (type == 'start') {
        startTimeController.text =
            "${userSelectedTime!.hour}:${userSelectedTime!.minute}";
      } else {
        endTimeController.text =
            "${userSelectedTime!.hour}:${userSelectedTime!.minute}";
      }
    }
    if (userSelectedDate != null && userSelectedTime != null) {
      dateTime = '${selectedDate.toString().substring(0, 10)} $selectedTime';
    }
    update();
  }
}
