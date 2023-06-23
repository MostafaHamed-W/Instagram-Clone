import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import '../utilities/colors.dart';
import '../utilities/utilities.dart';
import '../widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isfollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isfollowing = userSnap.data()!['followers'].contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(
      () {
        isLoading = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final UserProvider user = Provider.of<UserProvider>(context);
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userData['username']),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(userData['photoUrl']),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildStatColumn(postLen, 'Posts'),
                                buildStatColumn(followers, 'Followers'),
                                buildStatColumn(following, 'Following'),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          userData['fullname'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          userData['bio'],
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FirebaseAuth.instance.currentUser!.uid == widget.uid
                          ? Row(
                              children: [
                                Expanded(
                                  child: FollowBtton(
                                    function: () {},
                                    backgroungColor: const Color(0xff343434),
                                    borderColor: Colors.black,
                                    buttonText: 'Edit profile',
                                    textColor: primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: FollowBtton(
                                    function: () async {
                                      await AuthMethods().signOut();
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => const LoginScreen(),
                                        ),
                                      );
                                    },
                                    backgroungColor: Colors.blue,
                                    borderColor: Colors.black,
                                    buttonText: 'Sign out',
                                    textColor: primaryColor,
                                  ),
                                )
                              ],
                            )
                          : isfollowing
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: FollowBtton(
                                        function: () async {
                                          await FirestoreMethods().followUser(
                                              uid: FirebaseAuth.instance.currentUser!.uid,
                                              followId: userData['uid']);
                                          setState(
                                            () {
                                              isfollowing = false;
                                              followers--;
                                            },
                                          );
                                        },
                                        backgroungColor: const Color(0xff343434),
                                        borderColor: Colors.black,
                                        buttonText: 'Unfollow',
                                        textColor: primaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: FollowBtton(
                                        function: () {},
                                        backgroungColor: const Color(0xff343434),
                                        borderColor: Colors.black,
                                        buttonText: 'Message',
                                        textColor: primaryColor,
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: FollowBtton(
                                        function: () async {
                                          await FirestoreMethods().followUser(
                                              uid: FirebaseAuth.instance.currentUser!.uid,
                                              followId: userData['uid']);
                                          setState(() {
                                            isfollowing = true;
                                            followers++;
                                          });
                                        },
                                        backgroungColor: Colors.blue,
                                        borderColor: Colors.black,
                                        buttonText: 'Follow',
                                        textColor: primaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: FollowBtton(
                                        function: () {},
                                        backgroungColor: const Color(0xff343434),
                                        borderColor: Colors.black,
                                        buttonText: 'Message',
                                        textColor: primaryColor,
                                      ),
                                    )
                                  ],
                                )
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                          return Container(
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                snap['postUrl'],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 3),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
