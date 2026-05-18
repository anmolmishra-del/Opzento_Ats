import 'package:flutter/material.dart';
import 'package:opsento_ats/core/constants/app_colors.dart';
import 'package:opsento_ats/core/constants/app_image.dart';
import 'package:opsento_ats/routes/app_routes.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),

          child: Column(

            children: [

              const SizedBox(height: 50),

              // IMAGE
              Expanded(

                flex: 4,

                child: Image.asset(
                  AppImage.onboard,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              // TITLE
              const Text(

                "Welcome Back!",

                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 14),

              // SUBTITLE
              const Text(

                "Sign in to continue to your account",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),

              const Spacer(),

              // LOGIN BUTTON
              SizedBox(

                width: double.infinity,
                height: 58,

                child: ElevatedButton(

                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                        AppColors.primary,

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),

                  child: const Text(

                    "Login",

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // SIGNUP
              Row(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  const Text(

                    "Don't have an account? ",

                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),

                  GestureDetector(

                    onTap: () {},

                    child: const Text(

                      "Sign up",

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B2EFF),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}