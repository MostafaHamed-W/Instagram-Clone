import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utilities/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return
        //  Center(
        //   child: Container(
        //     child: IconButton(
        //       onPressed: () {},
        //       icon: Icon(Icons.upload),
        //     ),
        //   ),
        // );
        Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("New post"),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Share",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1685266324976-02cf0cc45f01?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Write a caption...",
                    border: InputBorder.none,
                  ),
                  maxLines: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: AspectRatio(
                      aspectRatio: 487 / 451,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            alignment: FractionalOffset.topCenter,
                            image: NetworkImage(
                              'https://images.pexels.com/photos/14818545/pexels-photo-14818545.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                            ),
                          ),
                        ),
                      )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
