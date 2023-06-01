import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/utilities.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a post"),
            children: [
              SimpleDialogOption(
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text('Choose from gellary'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    String name = userProvider.getUser.email;
    return _file == null
        ? Center(
            child: Container(
              child: IconButton(
                onPressed: () {
                  print(name);
                  _selectImage(context);
                },
                icon: const Icon(Icons.upload),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: const Text("New post"),
              centerTitle: true,
              leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              actions: [
                TextButton(
                  onPressed: () {
                    _selectImage(context);
                  },
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
                    CircleAvatar(
                      backgroundImage: NetworkImage(userProvider.getUser.photoUrl),
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
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  alignment: FractionalOffset.topCenter,
                                  image: MemoryImage(_file!),
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
