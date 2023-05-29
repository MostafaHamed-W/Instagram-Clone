import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/utilities.dart';
import 'package:instagram_clone/widgets/text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().signUpUsers(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      fullname: _fullNameController.text,
      file: _image!,
    );

    if (result != "success") {
      showSnackBar(context, result);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout(),
        );
      }));
    } else {
      showSnackBar(context, "Sign up successfully");
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(flex: 4, child: Container()),
                //svg image of instagram
                SvgPicture.asset(
                  'assets/instagram_clone.svg',
                  height: 64,
                  color: primaryColor,
                ),
                const SizedBox(height: 50),
                // circular user photo
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/001/840/612/original/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-free-vector.jpg',
                            ),
                          ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo_rounded),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Username textfield
                TextFieldInput(
                  inputController: _usernameController,
                  hintText: "Username",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                // email textfield
                TextFieldInput(
                  inputController: _emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                // fullname textfield
                TextFieldInput(
                  inputController: _fullNameController,
                  hintText: "Full Name",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                // password text field
                TextFieldInput(
                  inputController: _passwordController,
                  hintText: "Enter password",
                  keyboardType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(height: 20),
                //login button
                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                    child: const Text("Sign up"),
                  ),
                ),
                Flexible(flex: 4, child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: const Text("Already have an account?"),
                    ),
                    GestureDetector(
                      onTap: () => navigateToLogin(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                        child: const Text(
                          "Log in.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                //transitioning to sign in
              ],
            ),
          ),
        ),
      ),
    );
  }
}
