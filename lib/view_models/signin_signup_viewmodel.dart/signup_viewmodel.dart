import 'package:evika/data/remote/api_responce.dart';
import 'package:evika/models/user/user_model.dart';
import 'package:evika/repositories/login_repo/login_repo_imp.dart';
import 'package:evika/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding_resolver/geocoding_resolver.dart';
import 'package:location/location.dart';

class SignupVM extends GetxController {
  ApiResponce<Map> response = ApiResponce.loading();
  final LoginRepoImp loginRepo = LoginRepoImp();

  UserModel userModel = Get.put(UserModel());
  RxInt _currentStep = 0.obs;
  RxBool _isSignup = false.obs;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _accountTypeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  TextEditingController locality1 = TextEditingController();
  TextEditingController adminArea1 = TextEditingController();
  TextEditingController postalCode1 = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get mobileController => _mobileController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get accountTypeController => _accountTypeController;

  bool rememberMeBool = false;
  bool showPasswordBool = true;
  List<double> coordinatesPoints = [];
  void showPassword() {
    showPasswordBool = !showPasswordBool;
    update();
  }

  bool isNextClicked = false;
  String selectedValue = "";

  var first1;
  LocationData? locationData;
  GeoCoder geoCoder = GeoCoder();

  void _determinePosition() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print("!_serviceEnabled");
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print("_permissionGranted != PermissionStatus.granted");
        return;
      }
    }

    locationData = await location.getLocation();
    update();

    // Passed the coordinates of latitude and longitude
    coordinatesPoints.add(locationData!.longitude!);
    coordinatesPoints.add(locationData!.longitude!);
    // final coordinates =
    //     Coordinates(locationData!.latitude, locationData!.longitude);
    var address = await geoCoder.getAddressFromLatLng(
        latitude: locationData!.longitude!,
        longitude: locationData!.longitude!);
    var first = address.addressDetails;
    // on below line we have set the address to string
    // locality1.text = first.locality.toString();
    // adminArea1.text = first.adminArea.toString();
    // postalCode1.text = first.postalCode.toString();
    locality1.text = first.city.toString();
    adminArea1.text = first.state.toString();
    postalCode1.text = first.postcode.toString();

    /// update ui

    /// get continuous location updates
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   // Use current location
    // });

    /// receive location when application is in background
    // location.enableBackgroundMode(enable: true);
  }

  void _findPositionByAddress() async {
    //changing entered user address to coordinates
    final query = "${locality1.text} ${adminArea1.text} ${postalCode1.text}";
    var address1 = await geoCoder.getAddressSuggestions(address: query);
    first1 = address1.first;
    update();
    coordinatesPoints.add(first1.coordinates.longitude);
    coordinatesPoints.add(first1.coordinates.latitude);
    update();
    debugPrint("coordinates : ${first1.coordinates.latitude}");
  }

  get determinePosition => _determinePosition;
  get findPositionByAddress => _findPositionByAddress;

  Future<Map?> userSignup() async {
    Map data = {
      'name': nameController.text,
      'username': usernameController.text,
      'email': emailController.text,
      'mobile': mobileController.text,
      'password': passwordController.text,
      'confirmPassword': passwordController.text,
      'accountType': selectedValue,
      'location': coordinatesPoints.toString()
    };
    Map<dynamic, dynamic>? response = await loginRepo.userSignup(data);

    if (response!["status"] == "success") {
      _isSignup.value = true;
      Get.offAllNamed(AppRotutes.signin);
    }
    Get.snackbar(response["status"], response["message"]);
    return null;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    nameController.clear();
    confirmPasswordController.clear();
    mobileController.clear();
  }
}
