import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoir/providers/user_memory.dart';
import 'package:memoir/core/utils/photo_input.dart';

class AddMemoryScreen extends ConsumerStatefulWidget {
  const AddMemoryScreen({super.key});

  @override
  ConsumerState<AddMemoryScreen> createState() => _AddMemoryState();
}

class _AddMemoryState extends ConsumerState<AddMemoryScreen> {
  final _titleController = TextEditingController();
  File? _pickedPhoto;

  void _saveMemory() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty) return;
    ref
        .read(userMemoryProvider.notifier)
        .addMemory(enteredTitle, _pickedPhoto!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                label: Text("Eg. A day in mustang"),
              ),
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(
              height: 20,
            ),
            PhotoInput(onPickPhoto: (photo) {
              _pickedPhoto = photo;
            }),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: _saveMemory,
              icon: Icon(Icons.save),
              label: const Text("Add place"),
            ),
          ],
        ),
      ),
    );
  }
}
