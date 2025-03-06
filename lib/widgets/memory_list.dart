import 'package:flutter/material.dart';
import 'package:memoir/models/memory.dart';
import 'package:memoir/screens/memory_details.dart';

class MemoryList extends StatelessWidget {
  const MemoryList({super.key, required this.places});
  final List<Memory> places;
  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
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
        itemCount: places.length,
        itemBuilder: (ctx, index) => ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) =>
                        MemoryDetailsScreen(place: places[index])));
              },
              title: Text(
                places[index].title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ));
  }
}
