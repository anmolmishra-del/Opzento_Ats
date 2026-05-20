// import 'package:flutter/material.dart';
// import 'package:opsento_ats/features/candidatefolder/candidate_home/presentaion/home_page.dart';
// import 'package:opsento_ats/features/candidatefolder/candidate_interview/presention/interview_page.dart';

// import 'package:opsento_ats/features/jobs/presentaion/job_page.dart';

// import 'package:opsento_ats/features/my_applications/presentaion/my_appication_page.dart';

// import 'package:opsento_ats/features/interview_schedule/presention/interview_page.dart';



// class CandidateMainLayout
//     extends StatefulWidget {

//   const CandidateMainLayout({
//     super.key,
//   });

//   @override
//   State<CandidateMainLayout>
//       createState() =>
//           _CandidateMainLayoutState();
// }

// class _CandidateMainLayoutState
//     extends State<CandidateMainLayout> {

//   int currentIndex = 0;

//   final List<Widget> pages = [

// CandidateHomePage(),
//     const JobPage(isRecruiter: false,),

//     const MyApplicationPage(),

//     const InterviewSchedulePage(),
// CandidateInterviewPage(),
//     // const CandidateProfilePage(),
//   ];

//   void onTabChanged(int index) {

//     setState(() {
//       currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       backgroundColor: Colors.white,

//       body: pages[currentIndex],

//       bottomNavigationBar: Container(
//         margin:
//             const EdgeInsets.all(16),

//         padding:
//             const EdgeInsets.symmetric(
//           vertical: 20,
//         ),

//         decoration: BoxDecoration(
//           color:
//               Colors.white.withOpacity(0.9),

//           borderRadius:
//               BorderRadius.circular(30),

//           border: Border.all(
//             color: Colors.grey.shade200,
//           ),
//         ),

//         child: Row(
//           mainAxisAlignment:
//               MainAxisAlignment.spaceAround,

//           children: [

//             _item(
//               Icons.home,
//               "Home",
//               0,
//             ),

//             _item(
//               Icons.work,
//               "Jobs",
//               1,
//             ),

//             _item(
//               Icons.description,
//               "Applications",
//               2,
//             ),

//             _item(
//               Icons.event,
//               "Interviews",
//               3,
//             ),

//             _item(
//               Icons.person,
//               "Profile",
//               4,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _item(
//     IconData icon,
//     String label,
//     int index,
//   ) {

//     final isSelected =
//         currentIndex == index;

//     return GestureDetector(
//       onTap: () {
//         onTabChanged(index);
//       },

//       child: AnimatedContainer(
//         duration:
//             const Duration(
//           milliseconds: 250,
//         ),

//         padding:
//             const EdgeInsets.symmetric(
//           horizontal: 10,
//           vertical: 6,
//         ),

//         decoration: BoxDecoration(
//           color: isSelected
//               ? Colors.deepPurple
//                   .withOpacity(0.15)
//               : Colors.transparent,

//           borderRadius:
//               BorderRadius.circular(20),
//         ),

//         child: Row(
//           children: [

//             Icon(
//               icon,
//               size: 22,

//               color: isSelected
//                   ? Colors.deepPurple
//                   : Colors.grey,
//             ),

//             if (isSelected) ...[

//               const SizedBox(
//                   width: 6),

//               Text(
//                 label,

//                 style: const TextStyle(
//                   fontSize: 12,

//                   color:
//                       Colors.deepPurple,

//                   fontWeight:
//                       FontWeight.w600,
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }