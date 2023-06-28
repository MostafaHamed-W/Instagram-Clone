import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/sign_up_screen.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/global_variables.dart';
import 'package:instagram_clone/utilities/utilities.dart';
import 'package:instagram_clone/widgets/text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods()
        .loginUser(email: _emailController.text, password: _passwordController.text);

    if (result != "Logged in successfully") {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, result);
    } else {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout(),
        );
      }));
    }
  }

  void navigateToSignup() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SignUpScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Container(
            padding: MediaQuery.of(context).size.width > webScreenSize
                ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4)
                : const EdgeInsets.symmetric(horizontal: 32),
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
                const SizedBox(height: 64),
                // email textfield
                TextFieldInput(
                  inputController: _emailController,
                  hintText: "Enter Email",
                  keyboardType: TextInputType.text,
                ),
                // password text field
                const SizedBox(height: 20),
                TextFieldInput(
                  inputController: _passwordController,
                  hintText: "Enter password",
                  keyboardType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(height: 20),
                //login button
                InkWell(
                  onTap: () {
                    signInUser();
                  },
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
                    child: const Text("Log in"),
                  ),
                ),
                Flexible(flex: 4, child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: const Text("Don't have an account"),
                    ),
                    GestureDetector(
                      onTap: () => navigateToSignup(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                        child: const Text(
                          "Sign up.",
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
