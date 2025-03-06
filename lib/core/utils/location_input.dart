import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

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
    final url = Uri.http(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=YOUR_API_KEY');
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
