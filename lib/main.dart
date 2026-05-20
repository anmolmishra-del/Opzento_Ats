import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:opsento_ats/features/bottomnavbar/candidate/presentation/candidate_main_layout.dart';
import 'package:opsento_ats/features/splash_screen/splash_screen.dart';

import 'package:opsento_ats/routes/app_routes.dart';

import 'package:opsento_ats/features/jobs/cubit/job_cubit.dart';

import 'package:opsento_ats/features/my_applications/cubit/my_application_cubit.dart';

import 'package:opsento_ats/features/interview_schedule/cubit/interview_cubit.dart';

void main() {

  runApp(

    MultiBlocProvider(

      providers: [

        BlocProvider(
          create: (_) => JobCubit(),
        ),

        BlocProvider(
          create: (_) =>
              MyApplicationCubit(),
        ),

        // ADD THIS
        BlocProvider(
          create: (_) =>
              InterviewScheduleCubit(),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
home: SplashPage(),
      // home: RecruiterMainLayout(),

      // home: CandidateMainLayout(),

      onGenerateRoute:
          AppRoutes.generateRoute,
    );
  }
}