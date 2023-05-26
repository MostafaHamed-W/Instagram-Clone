import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 4, child: Container()),
              //svg image of instagram
              SvgPicture.asset(
                'lib/assets/instagram_clone.svg',
                height: 64,
                color: primaryColor,
              ),
              const SizedBox(height: 64),
              // username or email textfield
              TextFieldInput(
                inputController: _emailController,
                hintText: "Username, email or mobile number",
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
              Container(
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
              Flexible(flex: 4, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: const Text("Don't have an account"),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                    child: const Text(
                      "Sign up.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              //transitioning to sign in
            ],
          ),
        ),
      ),
    );
  }
}