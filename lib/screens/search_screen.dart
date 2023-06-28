import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/utilities/global_variables.dart';

class SearchScrean extends StatefulWidget {
  const SearchScrean({super.key});

  @override
  State<SearchScrean> createState() => _SearchScreanState();
}

class _SearchScreanState extends State<SearchScrean> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Search for a user',
          ),
          onFieldSubmitted: (value) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username',
                    isGreaterThanOrEqualTo: searchController.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    var data = doc.data();
                    if (!data.containsKey('username') || !data.containsKey('photoUrl')) {
                      // If the document data is null or does not contain the 'username' or 'photoUrl' fields,
                      // return an empty container or an error widget.
                      return Container();
                    }
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ProfileScreen(uid: data['uid']))),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            data['photoUrl'],
                          ),
                        ),
                        title: Text(
                          data['username'],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var photos = (snapshot.data! as dynamic).docs.map((doc) => doc['postUrl']).toList();
                photos.shuffle();
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: photos.length,
                  itemBuilder: (context, index) => Image.network(
                    photos[index],
                    fit: BoxFit.cover,
                  ),
                  staggeredTileBuilder: (index) => MediaQuery.of(context).size.width > webScreenSize
                      ? StaggeredTile.count(
                          (index % 7 == 0 ? 1 : 1),
                          (index % 7 == 0 ? 1 : 1),
                        )
                      : StaggeredTile.count(
                          (index % 7 == 0 ? 2 : 1),
                          (index % 7 == 0 ? 2 : 1),
                        ),
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                );
              },
            ),
    );
  }
}
