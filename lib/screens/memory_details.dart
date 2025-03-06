import 'package:flutter/material.dart';
import 'package:memoir/models/memory.dart';

class MemoryDetailsScreen extends StatelessWidget {
  const MemoryDetailsScreen({super.key, required this.memory});
  final Memory memory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(memory.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: FileImage(memory.photo),
            ),
          ],
        ),
      ),
    );
  }
}
