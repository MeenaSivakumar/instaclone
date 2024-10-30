import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/profile_screen.dart';

class FollowingUsers extends StatelessWidget {
  final List<String> followingList;
  const FollowingUsers({super.key, required this.followingList});

  Future<List<DocumentSnapshot>> getFollowingUsers() async {
    List<DocumentSnapshot> userDocs = [];

    for (String uid in followingList) {
      DocumentSnapshot userSnap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userDocs.add(userSnap);
    }
    return userDocs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: getFollowingUsers(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final followingUsers = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: followingUsers.length,
          itemBuilder: (context, index) {
            var user = followingUsers[index].data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        uid: user['uid'],
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        user['photourl'], // Access the 'photourl' here
                      ),
                      radius: 30,
                    ),

                    const SizedBox(
                      height: 4,
                    ), // Space between image and text
                    Text(
                      user['username'], // Display username
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
