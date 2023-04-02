// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:evika/models/user/post_model.dart' as postModel;
import 'package:evika/repositories/login_repo/login_repo_imp.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class GetLocation {
  var first1;

  final LoginRepoImp loginRepo = LoginRepoImp();
  List<double> coordinatesPoints = [];
  LocationData? locationData;

  Future determinePosition() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("!_serviceEnabled");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("_permissionGranted != PermissionStatus.granted");
        return;
      }
    }
    // location fetching

    locationData = await location.getLocation();

    // Passed the coordinates of latitude and longitude
    coordinatesPoints.add(locationData!.longitude!);
    coordinatesPoints.add(locationData!.latitude!);
    final coordinates =
        Coordinates(locationData!.latitude, locationData!.longitude);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = address.first;
    // on below line we have set the address to string
    return {
      "coordinates": coordinatesPoints,
      "country": "india",
      "state": first.adminArea.toString(),
      "zipcode": first.postalCode.toString(),
      "address1": first.locality.toString(),
    };
  }

  Future<postModel.Address> findAdressByPosition(
      double latitude, double longitude) async {
    debugPrint("latitude : $latitude longitude : $longitude");
    final coordinates = Coordinates(latitude, longitude);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var first = address.first;
    List<double> coordinatesPots = [];
    coordinatesPots.add(first.coordinates.longitude);
    coordinatesPots.add(first.coordinates.latitude);
    // debugPrint(
    //     "coordinates : ${first.subAdminArea} ${first.adminArea} ${first.postalCode} looooo ${first.locality} ffffnnnn ${first.featureName} addline ${first.addressLine} subb ${first.subLocality}");
    return postModel.Address(
      coordinates: coordinatesPots,
      country: "india",
      state: first.adminArea.toString(),
      zipcode: first.postalCode.toString(),
      address1: first.addressLine.toString(),
    );
  }

  Future<postModel.Address> findPositionByAddress(
      String locality1, String adminArea1, String postalCode1) async {
    //changing entered user address to coordinates
    final query = "${locality1} ${adminArea1} ${postalCode1}";
    var address1 = await Geocoder.local.findAddressesFromQuery(query);
    first1 = address1.first;
    coordinatesPoints.add(first1.coordinates.longitude);
    coordinatesPoints.add(first1.coordinates.latitude);
    debugPrint("coordinates : ${first1.coordinates.latitude}");
    postModel.Address address = postModel.Address(
      coordinates: coordinatesPoints,
      country: "india",
      state: adminArea1,
      zipcode: postalCode1,
      address1: locality1,
    );
    return address;
  }

  Future<Map?> updateUserLocation() async {
    await determinePosition();
    Map updateLocation = {'location': coordinatesPoints.toString()};
    Map<dynamic, dynamic>? response =
        await loginRepo.updateUserLocation(updateLocation);
    debugPrint(response!['message']);
    return response;
  }
}
