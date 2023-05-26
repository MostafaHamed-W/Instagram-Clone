import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utilities/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBdYKquAKQ5_QTiEhC13D3qGvN-QELcChY",
      appId: "1:923956321064:web:fe36b77a2f68b7cd9cce1d",
      messagingSenderId: "923956321064",
      projectId: "instagram-clone-87631",
      storageBucket: "instagram-clone-87631.appspot.com",
    ));
  } else {
    Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home:
          //   const ResponsiveLayout(
          //   webScreenLayout: WebScreenLayout(),
          //   mobileScreenLayout: MobileScreenLayout(),
          // ),
          LoginScreen(),
    );
  }
}
