import 'package:flutter/material.dart';
import 'package:memoir/models/memory.dart';

class MemoryDetailsScreen extends StatelessWidget {
  const MemoryDetailsScreen({super.key, required this.place});
  final Memory place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Center(
        child: Text(
          place.title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
