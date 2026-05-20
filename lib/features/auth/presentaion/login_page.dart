import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:opsento_ats/core/constants/app_colors.dart';
import 'package:opsento_ats/core/constants/app_image.dart';
import 'package:opsento_ats/features/forget_password/presention/forget_password_page.dart';
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
import 'package:opsento_ats/routes/app_routes.dart';
import 'package:opsento_ats/features/auth/state/login_state.dart';

import '../cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (_) => LoginCubit(),

      child: Scaffold(

        backgroundColor: Colors.white,

        body: SafeArea(

          child: BlocConsumer<
              LoginCubit,
              LoginState>(

            listener: (context, state) {

              if (state.status ==
                  LoginStatus.success) {

                // ScaffoldMessenger.of(context)
                //     .showSnackBar(

                //   const SnackBar(
                //     content:
                //         Text(""),
                //   ),
                // );
                Navigator.pushReplacementNamed(context, AppRoutes.recruitermainlayout);
              }

              if (state.status ==
                  LoginStatus.error) {

                ScaffoldMessenger.of(context)
                    .showSnackBar(

                  SnackBar(
                    content:
                        Text(state.message),
                  ),
                );
              }
            },

            builder: (context, state) {

              final cubit =
                  context.read<LoginCubit>();

              return SingleChildScrollView(

                padding:
                    const EdgeInsets.all(24),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const SizedBox(height: 40),

                    const Text(

                      "Login",

                      style: TextStyle(
                        fontSize: 32,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(

                      "Please sign in to continue",

                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 50),

                    // EMAIL
<<<<<<< HEAD
                  

                    const SizedBox(height: 10),

                   TextField(
  controller: emailController,

  decoration: InputDecoration(

    labelText: "Email",

    floatingLabelBehavior:
        FloatingLabelBehavior.auto,

    border: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(14),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(14),

      borderSide: const BorderSide(
        color: Colors.deepPurple,
        width: 1.5,
      ),
    ),
  ),
),
                    const SizedBox(height: 20),

                   Row(

  mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

  children: [

    const Text(""),

    GestureDetector(

      onTap: () {

        Navigator.push(

          context,

          MaterialPageRoute(

            builder: (_) =>
                const ForgotPasswordPage(),
          ),
        );
      },

      child: const Text(

        "Forgot Password",

        style: TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),

                    const SizedBox(height: 10),
TextField(
  controller: passwordController,

  obscureText: state.obscurePassword,

  decoration: InputDecoration(

    labelText: "Password",

    floatingLabelBehavior:
        FloatingLabelBehavior.auto,

    border: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(14),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(14),

      borderSide: const BorderSide(
        color: Colors.deepPurple,
        width: 1.5,
      ),
    ),

    suffixIcon: IconButton(

      onPressed: () {
        cubit.togglePassword();
      },

      icon: Icon(
        state.obscurePassword
            ? Icons.visibility_off
            : Icons.visibility,
      ),
    ),
  ),
),
=======
                    const Text(
                      "Email",
                    ),

                    const SizedBox(height: 10),

                    TextField(

                      controller:
                          emailController,

                      decoration:
                          InputDecoration(

                        hintText:
                            "",

                        border:
                            OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),
                    ),
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc

                    const SizedBox(height: 20),

                    Row(

<<<<<<< HEAD
                      children: [

                        Checkbox(

                          value:
                              state.rememberMe,

                          onChanged: (value) {

                            cubit.toggleRememberMe(
                              value!,
                            );
                          },
                        ),

                        const Text(
                          "Remember me",
=======
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: const [

                        Text("Password"),

                        Text(

                          "Forgot Password?",

                          style: TextStyle(
                            color:
                                Colors.deepPurple,
                          ),
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
                        ),
                      ],
                    ),

<<<<<<< HEAD
=======
                    const SizedBox(height: 10),

                    TextField(

                      controller:
                          passwordController,

                      obscureText:
                          state.obscurePassword,

                      decoration:
                          InputDecoration(

                        border:
                            OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(14),
                        ),

                        suffixIcon:
                            IconButton(

                          onPressed: () {

                            cubit.togglePassword();
                          },

                          icon: Icon(

                            state.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Row(

                    //   children: [

                    //     Checkbox(

                    //       value:
                    //           state.rememberMe,

                    //       onChanged: (value) {

                    //         cubit.toggleRememberMe(
                    //           value!,
                    //         );
                    //       },
                    //     ),

                    //     const Text(
                    //       "Remember me",
                    //     ),
                    //   ],
                    // ),

>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
                    const SizedBox(height: 20),

                    // LOGIN BUTTON
                    SizedBox(

                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(

                        onPressed: () {

                          cubit.login(

                            email:
                                emailController.text,

                            password:
                                passwordController.text,
                          );
                        },

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
<<<<<<< HEAD
                              AppColors.secondary,
=======
                              Colors.deepPurple,
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),

                        child:
                            state.status ==
                                    LoginStatus.loading

                                ? const CircularProgressIndicator(
                                    color:
                                        Colors.white,
                                  )

                                : const Text(

                                    "Login",

                                    style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Colors.white,
                                    ),
                                  ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    Row(

                      children: const [

<<<<<<< HEAD
                        Expanded(
                          child: Divider(),
                        ),
=======
                        // Expanded(
                        //   child: Divider(),
                        // ),
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc

                        Padding(

                          padding:
                              EdgeInsets.symmetric(
                            horizontal: 12,
                          ),

<<<<<<< HEAD
                          child: Text(
                            "or continue with",
                          ),
=======
                          // child: Text(
                          //   "or continue with",
                          // ),
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
                        ),

                        Expanded(
                          child: Divider(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

<<<<<<< HEAD
                   Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    /// GOOGLE BUTTON
    socialButton(
      image: AppImage.google,
      onTap: () {

        /// GOOGLE LOGIN FUNCTION
        debugPrint("Google Login");

      },
    ),

    const SizedBox(width: 20),

    /// MICROSOFT BUTTON
    socialButton(
      image: AppImage.micro,
      onTap: () {

        /// MICROSOFT LOGIN FUNCTION
        debugPrint("Microsoft Login");

      },
    ),
  ],
),
=======
                    // Row(

                    //   mainAxisAlignment:
                    //       MainAxisAlignment.center,

                    //   children: [

                    //     socialButton(
                    //       "G",
                    //     ),

                    //     const SizedBox(width: 20),

                    //     socialButton(
                    //       "⊞",
                    //     ),
                    //   ],
                    // ),
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget socialButton({
  required String image,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(14),

    child: Container(
      height: 65,
      width: 65,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
=======
  Widget socialButton(String text) {

    return Container(

      width: 65,
      height: 65,

      decoration: BoxDecoration(
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc

        border: Border.all(
          color: Colors.grey.shade300,
        ),

<<<<<<< HEAD
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

     child: Image.asset(
       image,
       height: 24,
       width: 24,
       fit: BoxFit.cover,
     ),
    ),
  );
 }
=======
        borderRadius:
            BorderRadius.circular(16),
      ),

      child: Center(

        child: Text(

          text,

          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
}