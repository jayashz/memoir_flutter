import 'package:flutter/material.dart';

class Custominput extends StatelessWidget {
  const Custominput({super.key, required this.onAddMemoryDescription});
  final Function(String des) onAddMemoryDescription;
  @override
  Widget build(BuildContext context) {
    TextEditingController? descriptionInp;
    return Container(
      height: 250,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              maxLines: null, // Allows multiple lines
              expands: true, // Makes the TextField take all available space
              controller: descriptionInp,
              onChanged: (value) {
                onAddMemoryDescription(value);
              },
              decoration: InputDecoration(
                hintText: 'Enter the description of your memory(Optional)',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
