import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoir/models/memory.dart';

class UserMemoryNotifier extends StateNotifier<List<Memory>> {
  UserMemoryNotifier() : super(const []);

  void addPlace(String title) {
    final newMemory = Memory(title: title);
    state = [...state, newMemory];
  }
}

final userMemoryProvider =
    StateNotifierProvider<UserMemoryNotifier, List<Memory>>(
        (ref) => UserMemoryNotifier());
