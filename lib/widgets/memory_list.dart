import 'package:flutter/material.dart';
import 'package:memoir/models/memory.dart';
import 'package:memoir/screens/memory_details.dart';

class MemoryList extends StatelessWidget {
  const MemoryList({super.key, required this.memories});
  final List<Memory> memories;
  @override
  Widget build(BuildContext context) {
    if (memories.isEmpty) {
      return Center(
        child: Text(
          "No Memories added.",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      );
    }
    return ListView.builder(
      itemCount: memories.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(12),
      itemBuilder: (ctx, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => MemoryDetailsScreen(memory: memories[index]),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Container(
            height: 250,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(memories[index].photo, scale: 1),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.bottomLeft,
            child: Text(
              memories[index].location.address,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
