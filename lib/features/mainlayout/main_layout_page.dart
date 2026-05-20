// import 'package:flutter/material.dart';
// import 'package:opsento_ats/features/candidatefolder/candidate/presentaion/candidate_page.dart';
// import 'package:opsento_ats/features/candidatefolder/candidate_screen/presentaion/candidate_page.dart';
// import 'package:opsento_ats/features/dashboard/presentaion/dashboard_page.dart';
// import 'package:opsento_ats/features/interview_schedule/presention/interview_page.dart';
// import 'package:opsento_ats/features/my_applications/presentaion/my_appication_page.dart';

// class MainLayout extends StatefulWidget {
//   const MainLayout({super.key});

//   @override
//   State<MainLayout> createState() => _MainLayoutState();
// }

// class _MainLayoutState extends State<MainLayout> {
//   int currentIndex = 0;

//   final List<Widget> pages = [
//     const DashboardPage(),
//     // const JobPage(),
//     const CandidatePage(),
//     MyApplicationPage(),
// const InterviewSchedulePage(),
// CandidateProfilePage(),    // MorePage(),
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

//       // PAGE BODY
//       body: pages[currentIndex],

//       // GLASS BOTTOM NAVBAR
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.all(16),
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.7),
//           borderRadius: BorderRadius.circular(30),
//           border: Border.all(color: Colors.grey.shade200),
//         ),

//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [

//             _item(Icons.home, "Home", 0),
//             _item(Icons.work, "Jobs", 1),
//             _item(Icons.people, "Candidates", 2),
//             _item(Icons.event, "Interviews", 3),
//             // _item(Icons.person, "profile", 4),
//             //  _item(Icons.more_horiz, "profile", 5),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _item(IconData icon, String label, int index) {
//     final isSelected = currentIndex == index;

//     return GestureDetector(
//       onTap: () => onTabChanged(index),

//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 250),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? Colors.deepPurple.withOpacity(0.15)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),

//         child: Row(
//           children: [
//             Icon(
//               icon,
//               size: 22,
//               color: isSelected ? Colors.deepPurple : Colors.grey,
//             ),

//             if (isSelected) ...[
//               const SizedBox(width: 6),
//               Text(
//                 label,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Colors.deepPurple,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }