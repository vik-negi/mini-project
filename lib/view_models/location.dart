import 'package:evika/models/user/post_model.dart' as postModel;
import 'package:evika/repositories/login_repo/login_repo_imp.dart';
import 'package:flutter/material.dart';
import 'package:geocoding_resolver/geocoding_resolver.dart';
import 'package:location/location.dart';

class GetLocation {
  var first1;
  GeoCoder geoCoder = GeoCoder();
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

    coordinatesPoints.add(locationData!.longitude!);
    coordinatesPoints.add(locationData!.latitude!);
    var address = await geoCoder.getAddressFromLatLng(
        latitude: locationData!.latitude!, longitude: locationData!.longitude!);
    var addressDetails = address.addressDetails;
    return {
      "coordinates": coordinatesPoints,
      "country": addressDetails.country.toString(),
      "state": addressDetails.state.toString(),
      "zipcode": addressDetails.postcode.toString(),
      "address1": addressDetails.city.toString(),
    };
  }

  Future<postModel.Address> findAdressByPosition(
      double latitude, double longitude) async {
    debugPrint("latitude : $latitude longitude : $longitude");
    // final coordinates = Coordinates(latitude, longitude);
    // var address =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var address = await geoCoder.getAddressFromLatLng(
      latitude: latitude,
      longitude: longitude,
    );

    var addressDetails = address.addressDetails;
    List<double> coordinatesPots = [];
    coordinatesPots.add(double.parse(address.lon));
    coordinatesPots.add(double.parse(address.lat));

    return postModel.Address(
      coordinates: coordinatesPots,
      country: addressDetails.country.toString(),
      state: addressDetails.state.toString(),
      zipcode: addressDetails.postcode.toString(),
      address1: addressDetails.city.toString(),
    );
  }

  Future<postModel.Address> findPositionByAddress(
      String locality1, String adminArea1, String postalCode1) async {
    //changing entered user address to coordinates
    final query = "${locality1} ${adminArea1} ${postalCode1}";
    // LookupAddress
    var address1 = await geoCoder.getAddressSuggestions(address: query);
    var first1 = address1.first;
    coordinatesPoints.add(double.parse(first1.longitude));
    coordinatesPoints.add(double.parse(first1.latitude));
    debugPrint("coordinates : ${first1.latitude}");
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
