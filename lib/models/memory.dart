import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation(
      {required this.address, required this.latitude, required this.longitude});
  final double latitude;
  final double longitude;
  final String address;
}

class Memory {
  Memory({required this.title, required this.photo, required this.location})
      : id = uuid.v4();

  final String id;
  final String title;
  final File photo;
  final PlaceLocation location;
}
