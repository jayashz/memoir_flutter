import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoir/core/utils/database.dart';
import 'package:memoir/models/memory.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class UserMemoryNotifier extends StateNotifier<List<Memory>> {
  UserMemoryNotifier() : super(const []);

  Future<void> loadMemories() async {
    final db = await getDataBase();
    final data = await db.query('user_memories');
    final memories = data
        .map(
          (row) => Memory(
              id: row['id'] as String,
              title: row['title'] as String,
              photo: File(row['photo'] as String),
              location: PlaceLocation(
                  address: row['address'] as String,
                  latitude: row['lat'] as double,
                  longitude: row['lng'] as double),
              memoryDescription: row['description'] as String),
        )
        .toList();
    state = memories;
  }

  void addMemory(String title, File photo, PlaceLocation place,
      String? memDescription) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(photo.path);
    final copiedPhoto = await photo.copy('${appDir.path}/$fileName');

    final newMemory = Memory(
        title: title,
        photo: copiedPhoto,
        location: place,
        memoryDescription: memDescription ?? "No description was added!");

    final db = await getDataBase();
    db.insert('user_memories', {
      'id': newMemory.id,
      'title': newMemory.title,
      'photo': newMemory.photo.path,
      'lat': newMemory.location.latitude,
      'lng': newMemory.location.longitude,
      'address': newMemory.location.address,
      'description': newMemory.memoryDescription,
    });
    state = [...state, newMemory];
  }
}

final userMemoryProvider =
    StateNotifierProvider<UserMemoryNotifier, List<Memory>>(
        (ref) => UserMemoryNotifier());
