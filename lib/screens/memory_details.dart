import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoir/core/utils/database.dart';
import 'package:memoir/models/memory.dart';
import 'package:memoir/providers/user_memory.dart';

class MemoryDetailsScreen extends ConsumerStatefulWidget {
  const MemoryDetailsScreen({super.key, required this.memory});
  final Memory memory;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemoryDetailsScreen();
}

class _MemoryDetailsScreen extends ConsumerState<MemoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memory.title),
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
                  image: FileImage(widget.memory.photo),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.heart),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: () {
                    ref
                        .read(userMemoryProvider.notifier)
                        .deleteMemory(widget.memory.id);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(CupertinoIcons.delete),
                  iconSize: 30,
                ),
              ],
            ),
            Text(
              widget.memory.memoryDescription,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
