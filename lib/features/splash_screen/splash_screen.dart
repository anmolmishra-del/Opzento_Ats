import 'dart:async';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
import 'package:opsento_ats/core/constants/app_image.dart';
import 'package:opsento_ats/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
<<<<<<< HEAD
  State<SplashPage> createState() =>
      _SplashPageState();
}

class _SplashPageState
    extends State<SplashPage> {
=======
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    navigateScreen();
  }

  Future<void> navigateScreen() async {

    const storage =
        FlutterSecureStorage();

    // LOGIN TOKEN
    final token =
        await storage.read(
      key: "token",
    );

    // FIRST INSTALL CHECK
    final firstTime =
        await storage.read(
      key: "first_time",
    );

    print("TOKEN => $token");
    print("FIRST TIME => $firstTime");

    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (!mounted) return;

    // FIRST TIME INSTALL
    if (firstTime == null) {

      await storage.write(
        key: "first_time",
        value: "done",
      );

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.signup,
      );

    }

    // USER ALREADY LOGIN
    else if (token != null) {

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.recruitermainlayout,
      );

    }

    // LOGIN PAGE
    else {

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.login,
      );
    }
=======
    navigateToOnboard();
  }

  void navigateToOnboard() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.onboard,
        );
      },
    );
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD

    return Scaffold(

=======
    return Scaffold(
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
      body: Stack(
        children: [

          // BACKGROUND IMAGE
          SizedBox.expand(
            child: Image.asset(
              AppImage.image,
              fit: BoxFit.cover,
            ),
          ),

<<<<<<< HEAD
          // CENTER TEXT
          const Center(
            child: Column(

              mainAxisSize:
                  MainAxisSize.min,

              children: [

                Text(
                  "HRMS ATS",

                  style: TextStyle(
                    fontSize: 26,
                    fontWeight:
                        FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "Smart Hiring, Better Future",

=======
          // OPTIONAL UI (if you want text, it must be here)
          const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "HRMS ATS",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Smart Hiring, Better Future",
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}