import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:memoir/core/utils/keys.dart';
import 'package:memoir/models/memory.dart';

class LocationInput extends StatefulWidget {
  LocationInput({super.key, required this.getLocation});
  void Function(PlaceLocation place) getLocation;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  var _isGettingLocation = false;

  void _getCurrentLocation() async {
    Location? location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();

    var latitude = locationData.latitude!;
    var longitude = locationData.longitude!;

    final url = Uri.parse(
        'https://api.geoapify.com/v1/geocode/reverse?lat=$latitude&lon=$longitude&apiKey=$mapApi');
    final response = await http.get(url);

    final res = jsonDecode(response.body.toString());
    final formattedLocation = res['features'][0]['properties']['formatted'];

    final userLocation = PlaceLocation(
        address: formattedLocation, latitude: latitude, longitude: longitude);

    widget.getLocation(userLocation);

    setState(() {
      _isGettingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location selected',
    );
    if (_isGettingLocation == true) {
      previewContent = CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
            height: 250,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: Theme.of(context).colorScheme.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(12)),
            child: previewContent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: Text('Get current location'),
              icon: Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {},
              label: Text('Pick location'),
              icon: Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}
