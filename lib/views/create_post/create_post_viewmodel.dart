import 'dart:convert';
import 'dart:io';
import 'package:evika/data/remote/api_responce.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:evika/data/remote/api_services/post_api_service.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:evika/repositories/post_repo/post_repo_imp.dart';
import 'package:evika/utils/colors.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/views/create_post/registrationFilelds.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostVM extends GetxController {
  ApiResponce<Map<dynamic, dynamic>?> response = ApiResponce.loading();
  PostData postData = PostData();
  List<PostData> postList = <PostData>[].obs;
  double attentionHeight = 0.0;

  late final Future? futurePosts;
  RxBool isPostFetched = false.obs;
  RxBool isErrorOnFetchingData = false.obs;

  final ImagePicker picker = ImagePicker();
  FilePicker filePicker = FilePicker.platform;

  String? dateTime;
  int viewImageIndex = 0;
  bool isRegistrationRequired = false;

  List<DateTime> startAndEndDate = [];

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  DateTime? userSelectedDate;
  TimeOfDay? userSelectedTime;
  List<XFile> selectedImages = [];

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
  final monthList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  void pickImage() async {
    final List<XFile>? images = await picker.pickMultiImage(
      imageQuality: 25,
    );
    if (images != null && images.isNotEmpty) {
      if (images.length <= 4 - selectedImages.length) {
        selectedImages.addAll(images);
      } else {
        Get.snackbar("Maximum 4 Images",
            "You can select ${4 - selectedImages.length} more images",
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.only(bottom: 30, left: 10, right: 10));
      }
    }
    update();
  }

  List<Widget> showImageRowList() {
    List<Widget> res = [];
    for (var image in selectedImages) {
      res.add(
        Stack(
          children: [
            InkWell(
              onTap: () {
                viewImageIndex = selectedImages.indexOf(image);
                update();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 60,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(image.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 5,
              child: InkWell(
                onTap: () {
                  if (viewImageIndex == selectedImages.indexOf(image)) {
                    viewImageIndex = 0;
                    update();
                    selectedImages.remove(image);
                    update();
                  }
                  selectedImages.remove(image);
                  update();
                },
                child: const Icon(
                  CupertinoIcons.multiply_circle_fill,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    }

    if (selectedImages.length < 4) {
      res.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: AppColors.accentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 60,
          height: 60,
          child: Center(
            child: IconButton(
              onPressed: () {
                pickImage();
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ),
      );
    }

    return res;
  }

  PostApiServices postApiServices = PostApiServices();

  Future<void> createPost() async {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter title");
      return;
    }
    try {
      debugPrint("chala");
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
      // tagString += "$element,";
      // });
      String tagString = "";
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
      request.fields["eventStartAt"] = startAndEndDate[0].toString();
      request.fields["isRegistrationRequired"] =
          isRegistrationRequired.toString();
      request.fields["eventEndAt"] = startAndEndDate[1].toString();
      request.fields["eventCategory"] = 'sports';
      // request.fields["tags"] = [];
      request.fields["userId"] = sharedPreferences.getString("user_id")!;
      for (var element in selectedImages) {
        request.files
            .add(await http.MultipartFile.fromPath("image", element.path));
      }

      print(request.fields.entries);
      // debugPrint("printing");
      // for (var i in request.fields.entries) {
      // }
      // debugPrint("printed");

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

  pickDates(context) async {
    startAndEndDate = await showOmniDateTimeRangePicker(
          context: context,
          type: OmniDateTimePickerType.dateAndTime,
          primaryColor: Colors.cyan,
          backgroundColor: Colors.grey[900],
          calendarTextColor: Colors.white,
          tabTextColor: Colors.white,
          unselectedTabBackgroundColor: Colors.grey[700],
          buttonTextColor: Colors.white,
          timeSpinnerTextStyle:
              const TextStyle(color: Colors.white70, fontSize: 18),
          timeSpinnerHighlightedTextStyle:
              const TextStyle(color: Colors.white, fontSize: 24),
          is24HourMode: false,
          isShowSeconds: false,
          startInitialDate: DateTime.now(),
          startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
          startLastDate: DateTime.now().add(
            const Duration(days: 3652),
          ),
          endInitialDate: DateTime.now(),
          endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
          endLastDate: DateTime.now().add(
            const Duration(days: 3652),
          ),
          borderRadius: const Radius.circular(16),
        ) ??
        [];

    update();
  }
}
