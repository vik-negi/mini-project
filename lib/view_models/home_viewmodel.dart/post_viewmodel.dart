import 'dart:convert';

import 'package:evika/data/remote/api_responce.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:evika/data/remote/api_services/post_api_service.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:evika/repositories/post_repo/post_repo_imp.dart';
import 'package:evika/utils/user_functionality.dart';
import 'package:evika/utils/widgets/login_first_dialogbox.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/view_models/location.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FilterOption {
  String name;
  bool isSelected;
  FilterOption({required this.name, required this.isSelected});
}

class PostVM extends GetxController {
  ApiResponce<Map<dynamic, dynamic>?> response = ApiResponce.loading();
  PostData postData = PostData();
  List<PostData> postList = <PostData>[].obs;
  String? postFilterRange;
  GetLocation getLocation = GetLocation();
  late final Future? futurePosts;
  RxBool isPostFetched = false.obs;
  RxBool isErrorOnFetchingData = false.obs;
  String checkBase = "Post View Model: ";

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  // create post
  final ImagePicker picker = ImagePicker();
  FilePicker filePicker = FilePicker.platform;
  String? filePath;

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
      filePath = image.path;
      selectedImage = image;
      debugPrint(image.path);
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    futurePosts = getAllPost();
    isUserLoggedInFun();
    updateUserLocation();
  }

  bool isUserLoggedIn = false;

  Future<void> isUserLoggedInFun() async {
    isUserLoggedIn = await UserFunctions.isUserLoggedInFun();
    update();
  }

  updateUserLocation() async {
    await getLocation.updateUserLocation();
  }

  PostApiServices postApiServices = PostApiServices();
  List<FilterOption> suggession = [
    FilterOption(name: "Global", isSelected: true),
    FilterOption(name: "India", isSelected: false),
    FilterOption(name: "Your State", isSelected: false),
    FilterOption(name: "Your City", isSelected: false),
    FilterOption(name: "Your Town", isSelected: false),
  ];

  createPostList(List<dynamic> list) {
    postList = [];
    for (int i = 0; i < list.length; i++) {
      String postdataStr = jsonEncode(list[i]);
      PostData postData = PostData.fromJson(postdataStr);
      postList.add(postData);
      isPostFetched.value = true;
      update();
    }
    debugPrint("${checkBase}Post List Length${postList.length}");
    return postList;
  }

  Future<List<PostData>?> getAllPost() async {
    response = ApiResponce.loading();
    isErrorOnFetchingData(false);
    isPostFetched(false);
    update();
    Map<dynamic, dynamic>? data = await postRepoImp.getAllPost();

    try {
      if (data != null) {
        debugPrint("getAllpost function Called");
        List<dynamic> list = data['data'];
        // debugPrint(data.toString());

        response = ApiResponce.completed(data);
        update();
        return createPostList(list);
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

    // debugPrint(checkBase + data.toString());
    try {
      if (data != null) {
        List<dynamic> list = data['posts'];
        response = ApiResponce.completed(data);
        update();
        return createPostList(list);
      } else {
        isPostFetched.value = false;
        isErrorOnFetchingData.value = true;
        response = ApiResponce.error("$checkBase No data found");
        update();
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      isPostFetched.value = false;
      isErrorOnFetchingData.value = true;
      response = ApiResponce.error("$checkBase No data found");
      update();
      return null;
    }
  }

  // CommonVM commonVM = Get.find<CommonVM>();

  void likePost(id) async {
    commonVM.tapOnLikeButtonFun(id);
    bool response = await postRepoImp.likePost(id);
    if (!response) {
      commonVM.tapOnLikeButtonFun(id);
    }
    // debugPrint("$checkBase Liked Post response : $response");
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
