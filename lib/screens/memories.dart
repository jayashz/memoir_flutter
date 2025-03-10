import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoir/core/constants/images.dart';
import 'package:memoir/providers/user_memory.dart';
import 'package:memoir/screens/add_memory.dart';
import 'package:memoir/widgets/memory_list.dart';

class MemoriesScreen extends ConsumerStatefulWidget {
  const MemoriesScreen({super.key});
  @override
  ConsumerState createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends ConsumerState<MemoriesScreen> {
  late Future<void> _memoriesFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _memoriesFuture = ref.read(userMemoryProvider.notifier).loadMemories();
  }

  @override
  Widget build(BuildContext context) {
    final userMemory = ref.watch(userMemoryProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            floating: true,
            title: Image.asset(
              Images.memoirLogoDark,
              height: 100,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const AddMemoryScreen()));
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: FutureBuilder(
                future: _memoriesFuture,
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(child: CircularProgressIndicator())
                        : MemoryList(memories: userMemory)),
          ),
        ],
      ),
    );
  }
}
