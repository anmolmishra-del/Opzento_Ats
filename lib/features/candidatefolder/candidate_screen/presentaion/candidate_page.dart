import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/core/constants/app_colors.dart';
<<<<<<< HEAD
import 'package:opsento_ats/features/candidatefolder/candidate/presentaion/candidate_page.dart';
import 'package:opsento_ats/features/candidatefolder/candidate_screen/cubit/candidate_screen_cubit.dart';
import 'package:opsento_ats/features/candidatefolder/candidate_screen/presentaion/resume_page.dart';
import 'package:opsento_ats/features/candidatefolder/candidate_screen/state/candidate_state.dart';
import 'package:opsento_ats/features/interview_schedule/presention/interview_page.dart';
=======
import 'package:opsento_ats/features/candidatefolder/candidate_screen/cubit/candidate_screen_cubit.dart';
import 'package:opsento_ats/features/candidatefolder/candidate_screen/presentaion/resume_page.dart';
import 'package:opsento_ats/features/candidatefolder/candidate_screen/state/candidate_state.dart';
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc


class CandidateProfilePage extends StatelessWidget {
  const CandidateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
       create: (_) => ProfileCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
<<<<<<< HEAD
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// PROFILE IMAGE
                      Center(
                        child: CircleAvatar(
                          radius: 58,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: const NetworkImage(
                            "https://i.pravatar.cc/300",
                          ),
                        ),
                      ),
                        
                      const SizedBox(height: 20),
                       
                      /// NAME
                      const Center(
                        child: Text(
                          "Arjun Mehta",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary
                          ),
                        ),
                      ),
                        
                      const SizedBox(height: 5),
                        
                      /// ROLE
                      const Center(
                        child: Text(
                          "Flutter Developer",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary
                          ),
                        ),
                      ),
                         Divider(),
                      const SizedBox(height: 35),
                        
                      /// INFO
                      const InfoTile(
                        icon: Icons.email_outlined,
                        text: "arjun.mehta@email.com",
                        iconColor: Colors.blue,
                      ),
                        
                      const SizedBox(height: 22),
                        
                      const InfoTile(
                        icon: Icons.phone_outlined,
                        text: "+91 98765 43210",
                         iconColor: Colors.green,
                      ),
                        
                      const SizedBox(height: 22),
                        
                      const InfoTile(
                        icon: Icons.location_on_outlined,
                        text: "Bangalore, India",
                          iconColor: Colors.red,
                
                      ),
                        
                      const SizedBox(height: 35),
                        
                      /// SKILLS TITLE
                      const Text(
                        "Skills",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                        
                      const SizedBox(height: 18),
                        
                      /// SKILLS
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: const [
                          SkillChip(title: "Flutter"),
                          SkillChip(title: "Dart"),
                          SkillChip(title: "Firebase"),
                          SkillChip(title: "REST API"),
                          SkillChip(title: "Dio"),
                           SkillChip(title: "Http"),
                        ],
                      ),
                        
                      const SizedBox(height: 30),
                        
                      /// EXPERIENCE
                      const Text(
                        "Experience",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                        
                      const SizedBox(height: 12),
                        
                      const Text(
                        "3.4 Years",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                        
                      // const Spacer(),
                      SizedBox(height: 30,),
                        
                      /// BUTTONS
                      Row(
                        children: [
                          ActionButton(
                            title: state!.isShortlisted
                                ? "Shortlisted"
                                : "Shortlist",
                            color: Colors.green.shade300,
                            onTap: () {
                              context
                                  .read<ProfileCubit>()
                                  .shortlist(context);
                                   Navigator.push(
                
                          context,
                
                          MaterialPageRoute(
                            builder: (_) =>
                  const InterviewSchedulePage(),
                          ));
                            },
                          ),
                        
                          const SizedBox(width: 14),
                        
                          ActionButton(
                            title: state.isRejected
                                ? "Rejected"
                                : "Reject",
                            color: Colors.red.shade300,
                            onTap: () {
                              context
                                  .read<ProfileCubit>()
                                  .reject(context);
                                   Navigator.pushReplacement(
                
                          context,
                
                          MaterialPageRoute(
                            builder: (_) =>
                  const CandidatePage(),
                          ));
                            },
                          ),
                        
                          const SizedBox(width: 14),
                        
                          Expanded(
                            child: InkWell(
                               onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<ProfileCubit>(),
                          child: const ResumePage(),
                        ),
                      ),
                    );
                  
                              },
                              borderRadius:
                                  BorderRadius.circular(12),
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                      border: Border.all(color: Colors.grey)
                                ),
                                child: const Text(
                                  "Resume",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
=======
              return Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// PROFILE IMAGE
                    Center(
                      child: CircleAvatar(
                        radius: 58,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: const NetworkImage(
                          "https://i.pravatar.cc/300",
                        ),
                      ),
                    ),
                      
                    const SizedBox(height: 20),
                     
                    /// NAME
                    const Center(
                      child: Text(
                        "Arjun Mehta",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary
                        ),
                      ),
                    ),
                      
                    const SizedBox(height: 8),
                      
                    /// ROLE
                    const Center(
                      child: Text(
                        "Flutter Developer",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary
                        ),
                      ),
                    ),
                       Divider(),
                    const SizedBox(height: 35),
                      
                    /// INFO
                    const InfoTile(
                      icon: Icons.email_outlined,
                      text: "arjun.mehta@email.com",
                    ),
                      
                    const SizedBox(height: 22),
                      
                    const InfoTile(
                      icon: Icons.phone_outlined,
                      text: "+91 98765 43210",
                    ),
                      
                    const SizedBox(height: 22),
                      
                    const InfoTile(
                      icon: Icons.location_on_outlined,
                      text: "Bangalore, India",
                    ),
                      
                    const SizedBox(height: 35),
                      
                    /// SKILLS TITLE
                    const Text(
                      "Skills",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                      
                    const SizedBox(height: 18),
                      
                    /// SKILLS
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: const [
                        SkillChip(title: "Flutter"),
                        SkillChip(title: "Dart"),
                        SkillChip(title: "Firebase"),
                        SkillChip(title: "REST API"),
                        SkillChip(title: "+3"),
                      ],
                    ),
                      
                    const SizedBox(height: 30),
                      
                    /// EXPERIENCE
                    const Text(
                      "Experience",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                      
                    const SizedBox(height: 12),
                      
                    const Text(
                      "3.4 Years",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                      
                    const Spacer(),
                      
                    /// BUTTONS
                    Row(
                      children: [
                        ActionButton(
                          title: state!.isShortlisted
                              ? "Shortlisted"
                              : "Shortlist",
                          color: Colors.green,
                          onTap: () {
                            context
                                .read<ProfileCubit>()
                                .shortlist(context);
                          },
                        ),
                      
                        const SizedBox(width: 14),
                      
                        ActionButton(
                          title: state.isRejected
                              ? "Rejected"
                              : "Reject",
                          color: Colors.red,
                          onTap: () {
                            context
                                .read<ProfileCubit>()
                                .reject(context);
                          },
                        ),
                      
                        const SizedBox(width: 14),
                      
                        Expanded(
                          child: InkWell(
                             onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ProfileCubit>(),
          child: const ResumePage(),
        ),
      ),
    );
  
                            },
                            borderRadius:
                                BorderRadius.circular(12),
                            child: Container(
                              height: 52,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                    BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey)
                              ),
                              child: const Text(
                                "Resume",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
                                ),
                              ),
                            ),
                          ),
<<<<<<< HEAD
                        ],
                      ),
                    ],
                  ),
=======
                        ),
                      ],
                    ),
                  ],
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onTap;
  final Color textColor;

  const ActionButton({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
<<<<<<< HEAD
          height: 50,
=======
          height: 52,
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
<<<<<<< HEAD
            border: Border.all(color: Colors.grey.shade300)    
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
          ),
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class SkillChip extends StatelessWidget {
  final String title;

  const SkillChip({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
<<<<<<< HEAD
        // color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade500,
        ),
=======
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
<<<<<<< HEAD
          // color: AppColors.primary
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
        ),
      ),
    );
  }
}
<<<<<<< HEAD
class InfoTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final Color iconColor;
=======

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String text;
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc

  const InfoTile({
    super.key,
    required this.icon,
    required this.text,
<<<<<<< HEAD
    required this.iconColor,
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD

    return Row(
      children: [

        Icon(
          icon,
          color: iconColor,
          size: 22,
        ),

        const SizedBox(width: 14),

=======
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black54,
          size: 22,
        ),
        const SizedBox(width: 14),
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}