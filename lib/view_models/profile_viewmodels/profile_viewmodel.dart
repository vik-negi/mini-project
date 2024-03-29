import 'dart:convert';

import 'package:evika/models/user/post_model.dart';
import 'package:evika/models/user/user_model.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:evika/view_models/location.dart';
import 'package:flutter/cupertino.dart';
// import 'package:evika/utils/sharedPreferenced.dart';
// import 'package:evika/utils/sharedPreferenced.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:share_plus/share_plus.dart';

class ProfileVM extends GetxController {
  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  GetLocation getLocation = GetLocation();

  UserData? userData;
  bool isLoading = false;

  setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future getUserFromSharedPrefes() async {
    setLoading(true);
    debugPrint("function call getuserformsharedprefes");
    var user = await SharedPrefs.getString("user");
    debugPrint(user);
    if (user != null) {
      var userDataMap = jsonDecode(user);
      userData = UserData.fromMap(userDataMap);
      await getUserDataToControllers();
    }
    setLoading(false);
  }

  @override
  onInit() async {
    debugPrint("onint in profile vm is running");
    super.onInit();
    await getUserFromSharedPrefes();
  }

  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  getUserDataToControllers() async {
    debugPrint(
        "get user data to controllers is running ${userData!.location}}");
    Address address = await getLocation.findAdressByPosition(28.7041, 77.1025);
    // Address address = Address(
    //     address1: "abc address",
    //     city: "abc address",
    //     state: "abc address",
    //     country: "abc address",
    //     zipcode: "abc address",
    //     coordinates: [28.7041, 77.1025]);
    print("address is ${address.state}");
    nameController.text = userData?.name ?? "";
    bioController.text = userData?.bio ?? "";
    addressController.text = address.address1 ?? address.state;
    pinController.text = address.zipcode;
    stateController.text = (address.state);
    countryController.text = address.country;
    emailController.text = userData?.email ?? "";
    mobileController.text = userData?.mobile ?? "";
    update();
  }
}
