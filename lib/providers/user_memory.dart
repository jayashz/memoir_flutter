import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoir/models/memory.dart';

class UserMemoryNotifier extends StateNotifier<List<Memory>> {
  UserMemoryNotifier() : super(const []);

  void addMemory(String title, File photo, PlaceLocation place) {
    final newMemory = Memory(title: title, photo: photo, location: place);
    state = [...state, newMemory];
  }
}

final userMemoryProvider =
    StateNotifierProvider<UserMemoryNotifier, List<Memory>>(
        (ref) => UserMemoryNotifier());
