import 'dart:convert';

import 'package:evika/data/remote/api_responce.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:evika/data/remote/api_services/post_api_service.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:evika/repositories/post_repo/post_repo_imp.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/view_models/location.dart';
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
  String? postFilterRange;
  GetLocation getLocation = GetLocation();

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
  TextEditingController commentController = TextEditingController();

  PostRepoImp postRepoImp = PostRepoImp();
  CommonVM commonVM = Get.put(CommonVM());

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
    updateUserLocation();
  }

  updateUserLocation() async {
    await getLocation.updateUserLocation();
  }

  PostApiServices postApiServices = PostApiServices();

  Future<List<PostData>?> getAllPost() async {
    response = ApiResponce.loading();
    isErrorOnFetchingData(false);
    isPostFetched(false);
    update();
    Map<dynamic, dynamic>? data = await postRepoImp.getAllPost();
    // debugPrint("ddddddddddd");
    // debugPrint(data.toString());

    try {
      if (data != null) {
        debugPrint("getAllpost function Called");
        List<dynamic> list = data['data'];
        debugPrint(data.toString());

        response = ApiResponce.completed(data);
        update();
        // postList = parsePhotos(postdata);
        postList = [];
        for (int i = 0; i < list.length; i++) {
          String postdataStr = jsonEncode(list[i]);
          PostData postData = PostData.fromJson(postdataStr);

          postList.add(postData);
          // print("llllllllllllll");
          // print(postList[i].eventId);
          isPostFetched.value = true;

          update();
        }
        print(postList.length);

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

  Future<List<PostData>?> filterPost() async {
    response = ApiResponce.loading();
    isErrorOnFetchingData(false);
    isPostFetched(false);
    update();
    Map range = {"maxrange": postFilterRange};
    Map<dynamic, dynamic>? data = await postRepoImp.filterPost(range);

    debugPrint(data.toString());
    try {
      if (data != null) {
        List<dynamic> list = data['posts'];
        response = ApiResponce.completed(data);
        update();
        postList = [];
        for (int i = 0; i < list.length; i++) {
          String postdataStr = jsonEncode(list[i]);
          PostData postData = PostData.fromJson(postdataStr);

          postList.add(postData);
          isPostFetched.value = true;

          update();
        }
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
      // http.Response tagsMap =
      //     await http.post(Uri.parse("$mlBaseUrl/api/keywords"), body: {
      //   "text": descriptionController.text,
      //   "user_id": "1",
      // });
      // String tagString = "";
      // List tagList = jsonDecode(tagsMap.body)["data"];
      // jsonDecode(tagsMap.body)["data"].forEach((element) {
      //   tagString += "$element,";
      // });
      // tagString = tagString.substring(0, tagString.length - 1);
      var request = http.MultipartRequest(
          "POST", Uri.parse("$baseUrl/api/user/create-post/"));
      request.headers["Authorization"] =
          "Bearer ${sharedPreferences.getString("token")}";
      request.fields["title"] = titleController.text;
      request.fields["description"] = descriptionController.text;
      request.fields["location"] = locationController.text;
      request.fields["eventDescription"] = eventDescriptionController.text;
      request.fields["eventStartAt"] =
          '${startDateController.text} ${startTimeController.text}';

      request.fields["eventEndAt"] =
          '${endDateController.text} ${endTimeController.text}';
      request.fields["eventCategory"] = 'sports';
      // request.fields["tags"] = tagString;
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
    Map<String, dynamic>? response = await postRepoImp.likePost(id);
    if (response != null) {
      print("uuuuuuuuuuuuuuu");
      print("Liked Post response : $response");
      List<String> likedPosts = [];

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
