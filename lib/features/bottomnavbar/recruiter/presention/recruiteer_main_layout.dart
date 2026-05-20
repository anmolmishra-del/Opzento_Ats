import 'package:flutter/material.dart';
import 'package:opsento_ats/features/candidatefolder/candidate/presentaion/candidate_page.dart';

import 'package:opsento_ats/features/dashboard/presentaion/dashboard_page.dart';
<<<<<<< HEAD
import 'package:opsento_ats/features/feed_back/presentaion/feed_back_page.dart';
import 'package:opsento_ats/features/jobs/presentaion/job_page.dart';
import 'package:opsento_ats/features/offer_approv/presetion/offere_screen.dart';
import 'package:opsento_ats/features/offer_later/presentaion/offer_later_page.dart';
=======
import 'package:opsento_ats/features/jobs/presentaion/job_page.dart';
import 'package:opsento_ats/features/interview_schedule/presention/interview_page.dart';
import 'package:opsento_ats/features/my_applications/presentaion/my_appication_page.dart';
import 'package:opsento_ats/features/recruiter/presentaion/recruiter_page.dart';
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc

class RecruiterMainLayout
    extends StatefulWidget {

  const RecruiterMainLayout({
    super.key,
  });

  @override
  State<RecruiterMainLayout>
      createState() =>
          _RecruiterMainLayoutState();
}

class _RecruiterMainLayoutState
    extends State<RecruiterMainLayout> {

  int currentIndex = 0;

  final List<Widget> pages = [

<<<<<<< HEAD
    DashboardPage(),
    JobPage(isRecruiter: true,),
    CandidatePage(),
     OfferApprovalPage(),
     InterviewFeedbackPage(),
    // const CandidatePipelinePage(),
   
    

// RecruiterProfilePage(),
     
      // OfferLetterPage(),
=======
    const DashboardPage(),

    const JobPage(isRecruiter: true,),

    // const CandidatePipelinePage(),
CandidatePage(),
    const InterviewSchedulePage(),

RecruiterProfilePage(),
    // const RecruiterProfilePage(),
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
  ];

  void onTabChanged(int index) {

    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: pages[currentIndex],

      bottomNavigationBar: Container(
        margin:
            const EdgeInsets.all(16),

        padding:
            const EdgeInsets.symmetric(
          vertical: 20,
        ),

        decoration: BoxDecoration(
          color:
              Colors.white.withOpacity(0.9),

          borderRadius:
              BorderRadius.circular(30),

          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,

          children: [

            _item(
              Icons.home,
              "Home",
              0,
            ),

            _item(
              Icons.work,
              "Jobs",
              1,
            ),

            // _item(
            //   Icons.people,
            //   "Candidates",
            //   2,
            // ),

            _item(
              Icons.people,
              "Candidate",
              2,
            ),

            _item(
<<<<<<< HEAD
              Icons.verified_rounded,
              "Approval",
              3,
            ),
            //  _item(
            //   Icons.rate_review,
            //   "Feedback",
            //   4,
            // ),
             _item(
              Icons.rate_review,
              "Feedback",
=======
              Icons.event,
              "Interviews",
              3,
            ),
             _item(
              Icons.person,
              "Profile",
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
              4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    IconData icon,
    String label,
    int index,
  ) {

    final isSelected =
        currentIndex == index;

    return GestureDetector(
      onTap: () {
        onTabChanged(index);
      },

      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 250,
        ),

        padding:
            const EdgeInsets.symmetric(
<<<<<<< HEAD
          horizontal: 15,
=======
          horizontal: 10,
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
          vertical: 6,
        ),

        decoration: BoxDecoration(
<<<<<<< HEAD
          // color: isSelected
          //     ? Colors.deepPurple
          //         .withOpacity(0.15)
          //     : Colors.transparent,
=======
          color: isSelected
              ? Colors.deepPurple
                  .withOpacity(0.15)
              : Colors.transparent,
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc

          borderRadius:
              BorderRadius.circular(20),
        ),

<<<<<<< HEAD
        child: Column(
          mainAxisSize: MainAxisSize.min,

=======
        child: Row(
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
          children: [

            Icon(
              icon,
              size: 22,

              color: isSelected
                  ? Colors.deepPurple
                  : Colors.grey,
            ),

            if (isSelected) ...[

              const SizedBox(
                  width: 6),

              Text(
                label,

                style: const TextStyle(
                  fontSize: 12,

                  color:
                      Colors.deepPurple,

                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
