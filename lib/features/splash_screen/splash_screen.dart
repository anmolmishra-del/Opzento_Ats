import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:opsento_ats/core/constants/app_image.dart';
import 'package:opsento_ats/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() =>
      _SplashPageState();
}

class _SplashPageState
    extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: [

          // BACKGROUND IMAGE
          SizedBox.expand(
            child: Image.asset(
              AppImage.image,
              fit: BoxFit.cover,
            ),
          ),

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