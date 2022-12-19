import 'dart:convert';
import 'dart:io';
import 'package:evika/data/remote/api_responce.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:evika/data/remote/api_services/post_api_service.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:evika/repositories/post_repo/post_repo_imp.dart';
import 'package:evika/utils/colors.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/views/create_post/registrationFilelds.dart';
import 'package:geocoder/geocoder.dart';
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

  var first1;
  List<double> coordinatesPoints = [];

  Future findPositionByAddress() async {
    coordinatesPoints = [];
    //changing entered user address to coordinates
    final query = "${locationController.text}";
    var address1 = await Geocoder.local.findAddressesFromQuery(query);
    first1 = address1.first;
    coordinatesPoints.add(first1.coordinates.longitude);
    coordinatesPoints.add(first1.coordinates.latitude);
    update();
    debugPrint(coordinatesPoints.toString());
    debugPrint("coordinates : ${first1.coordinates}");
  }

  clearAllFields() {}
  PostApiServices postApiServices = PostApiServices();

  Future<void> createPost() async {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter title");
      return;
    }
    try {
      debugPrint("chala");

      await findPositionByAddress();
      String tagString = "";
      var request = http.MultipartRequest(
          "POST", Uri.parse("$baseUrl/api/user/create-post/"));
      request.headers["Authorization"] =
          "Bearer ${await SharedPrefs.getString("token")}";
      request.fields["title"] = titleController.text;
      request.fields["description"] = descriptionController.text;
      request.fields["eventLocation"] = locationController.text;
      request.fields["eventLocation"] = coordinatesPoints.toString();
      // request.fields["eventLocation"] = [80.3319, 26.4499].toString();
      request.fields["eventDescription"] = eventDescriptionController.text;
      request.fields["eventStartAt"] = startAndEndDate[0].toString();
      request.fields["registrationRequired"] =
          isRegistrationRequired.toString();
      request.fields["eventEndAt"] = startAndEndDate[1].toString();
      request.fields["eventCategory"] = 'sports';
      // request.fields["tags"] = [];
      request.fields["userId"] = (await SharedPrefs.getString("userId"))!;
      for (var element in selectedImages) {
        request.files
            .add(await http.MultipartFile.fromPath("image", element.path));
      }

      print(request.fields.entries);
      String? response = await postRepoImp.createPost(request);
      debugPrint(response.toString());
      if (response != null) {
        Get.snackbar('Success', 'Post Created Successfully');
        debugPrint('Post Created Successfully');
        clearAllFields();
      } else {
        Get.snackbar('Error', 'Something went wrong');
        debugPrint("something went wrong");
      }
    } catch (err) {
      print("err : $err");
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
