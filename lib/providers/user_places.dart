import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoir/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);


  void addPlace(String title) {
    final newPlace = Place(title: title);
    state = [...state, newPlace];
  }
}

final userPlaceProvider = StateNotifierProvider((ref) => UserPlacesNotifier());
