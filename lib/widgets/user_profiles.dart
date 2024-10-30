import 'package:flutter/material.dart';

class UserProfiles extends StatelessWidget {
  final String photoUrl;
  final String username;
  final double radius;

  const UserProfiles({
    super.key,
    required this.photoUrl,
    required this.username,
    this.radius = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            photoUrl,
          ),
          radius: radius,
        ),
        const SizedBox(
          height: 4,
        ), // Space between image and text
        Text(
          username, // Display username
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
