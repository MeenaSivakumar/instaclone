import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/search_filed.dart';

class DispalyProfile extends StatefulWidget {
  final List<String> userIds;
  final String title;
  const DispalyProfile({
    super.key,
    required this.userIds,
    required this.title,
  });

  @override
  State<DispalyProfile> createState() => _DispalyProfileState();
}

class _DispalyProfileState extends State<DispalyProfile> {
  bool isShowUser = false;

  void onsubmitted(String _) {
    setState(() {
      isShowUser = true;
    });
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchFiled(
              controller: searchController,
              labelText: 'search ',
              onsubmitted: onsubmitted,
            ),
            Expanded(
              child: FutureBuilder(
                future: _getUsers(widget.userIds),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var users = snapshot.data! ;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var user = users[index].data() as dynamic;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            user['photourl'],
                          ),
                          radius: 20,
                        ),
                        title: Text(
                          user['username'],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                uid: user['uid'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<DocumentSnapshot>> _getUsers(List<String> userIds) async {
  List<DocumentSnapshot> userDocs = [];
  for (String uid in userIds) {
    var userSnap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    userDocs.add(userSnap);
  }
  return userDocs;
}
