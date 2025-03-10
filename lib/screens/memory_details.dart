import 'package:flutter/cupertino.dart';
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
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  image: FileImage(memory.photo),
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.heart),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.delete),
                ),
              ],
            ),
            Text(
              memory.memoryDescription,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
