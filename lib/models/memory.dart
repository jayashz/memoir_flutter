import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class Memory {
  Memory({required this.title, required this.photo}) : id = uuid.v4();

  final String id;
  final String title;
  final File photo;
}
