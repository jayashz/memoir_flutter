import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoir/providers/user_memory.dart';
import 'package:memoir/screens/add_memory.dart';
import 'package:memoir/widgets/memory_list.dart';

class MemoriesScreen extends ConsumerWidget {
  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userMemory = ref.watch(userMemoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo/Memoir.png',
          height: 100,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AddMemoryScreen()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: MemoryList(places: userMemory),
    );
  }
}
