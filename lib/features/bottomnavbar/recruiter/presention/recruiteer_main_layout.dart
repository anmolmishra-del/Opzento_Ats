import 'package:flutter/material.dart';
import 'package:opsento_ats/features/candidatefolder/candidate/presentaion/candidate_page.dart';

import 'package:opsento_ats/features/dashboard/presentaion/dashboard_page.dart';
import 'package:opsento_ats/features/feed_back/presentaion/feed_back_page.dart';
import 'package:opsento_ats/features/jobs/presentaion/job_page.dart';
import 'package:opsento_ats/features/offer_approv/presetion/offere_screen.dart';
import 'package:opsento_ats/features/offer_later/presentaion/offer_later_page.dart';

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

    DashboardPage(),
    JobPage(isRecruiter: true,),
    CandidatePage(),
     OfferApprovalPage(),
     InterviewFeedbackPage(),
    // const CandidatePipelinePage(),
   
    

// RecruiterProfilePage(),
     
      // OfferLetterPage(),
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
          horizontal: 15,
          vertical: 6,
        ),

        decoration: BoxDecoration(
          // color: isSelected
          //     ? Colors.deepPurple
          //         .withOpacity(0.15)
          //     : Colors.transparent,

          borderRadius:
              BorderRadius.circular(20),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,

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
