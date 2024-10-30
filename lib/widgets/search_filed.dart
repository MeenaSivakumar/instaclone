import 'package:flutter/material.dart';

class SearchFiled extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Function(String) onsubmitted;

  const SearchFiled({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onsubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 18,
          ),
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.blueGrey,
            ),
          ),
        ),
        onSubmitted: (value) {
          onsubmitted(value);
        },
      ),
    );
  }
}
