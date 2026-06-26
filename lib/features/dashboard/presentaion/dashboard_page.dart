import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/core/constants/app_colors.dart';
import 'package:opsento_ats/features/profile/presentation/profile_page.dart';
import '../cubit/dashboard_cubit.dart';
import '../state/dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: Scaffold(
// backgroundColor: const Color(0xFFF8FAFC),
     backgroundColor:  Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                final cubit = context.read<DashboardCubit>();
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TOP BAR
                      Container(
                         padding: const EdgeInsets.all(15),
decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(18),
  border: Border.all(
    color: Colors.grey.shade200,
  ),
  
  boxShadow: [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 20,
      offset: Offset(0, 10),
    ),
     BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 20,
      offset: Offset(0, 10),
    ),
  ],
),
                        child: Row(
                          children: [
                            const CircleAvatar(radius: 18),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Hello",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          
                                        ),
                                        
                                      ),
                                        SizedBox(width: 5),
        Icon(
          Icons.waving_hand,
          color: Colors.orange,
          size: 18,
        ),
                                    ],
                                  ),
          //                         SizedBox(width: 4),
          //                           Icon(
          //   Icons.waving_hand,
          //   color: Colors.orange,
          //   size: 18,
          // ),
                                FittedBox(
  fit: BoxFit.scaleDown,
  alignment: Alignment.centerLeft,
  child: Text(
    state.name,
    style: const TextStyle(
      fontSize: 16,
      
      fontWeight: FontWeight.w500,
    ),
  ),
)
                                ],
                              ),
                            ),
                            const Spacer(),
                            // IconButton(
                            //   icon: const Icon(Icons.notifications_none, size: 28),
                            //   onPressed: () {
                            //     Navigator.of(context).push(
                            //       MaterialPageRoute(
                            //         builder: (_) => const NotificationsPage(),
                            //       ),
                            //     );
                            //   },
                            // ),
                            IconButton(
                              icon: const Icon(Icons.person_outline, size: 28),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const RecruiterProfilePage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // const Text(
                      //   "Tuesday, 14 May 2024",
                      //   style: TextStyle(color: Colors.grey),
                      // ),

                      const SizedBox(height: 25),

                      // ERROR UI
                      // if (state.error != null)
              if (state.error != null)
  Text(
    state.error!,
    style: const TextStyle(
      color: Colors.red,
    ),
  ),
                      // GRID
                     SizedBox(

  // height: 140,

  child: GridView.builder(

    shrinkWrap: true,

    physics:
        const NeverScrollableScrollPhysics(),

    itemCount:
        state.titles.length,

    gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(

      crossAxisCount: 2,

      crossAxisSpacing: 16,

      mainAxisSpacing: 16,

      childAspectRatio: 1.4,
    ),

    itemBuilder:
        (context, index) {

      return _Card(

        title:
            state.titles[index],

        count:

            state.counts.isNotEmpty &&

                    index <
                        state.counts.length

                ? state.counts[index]
                : 0,
      );
    },
  ),
),

                      const SizedBox(height: 20),

                      // FILTER
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text(
                      //       "Hiring Funnel",
                      //       style: TextStyle(
                      //         fontSize: 22,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         cubit.changeFilter("This Month");
                      //       },
                      //       child: Container(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 12, vertical: 8),
                      //         decoration: BoxDecoration(
                      //           border: Border.all(color: Colors.grey.shade300),
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         child: Text(state.selectedFilter),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      const SizedBox(height: 15),

                      // LOADING
                      // if (state.isLoading)
                      //   const Center(child: CircularProgressIndicator())
                      // else
//                         SizedBox(
//                           height: 220,
//                           child: Row(
//                             mainAxisAlignment:
//                                 MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children:
//     state.chartValues
//         .asMap()
//         .entries
//         .map((entry) {

//   final labels = [

//     "Applied",

//     "Screening",

//     "Interview",

//     "Offer",

//     "Hired",
//   ];

//   return _ChartBar(

//     value:
//         entry.value,

//   label:
//     entry.key < labels.length
//         ? labels[entry.key]
//         : "Unknown",
//   );

// }).toList(),
//                           ),
//                         ),

                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
class _ChartBar extends StatelessWidget {
  // final double height;
  final double value;

  final String label;
  const _ChartBar({super.key, 
    required this.value,

    required this.label,});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.end,

      children: [
        Container(
          width: 30,
          height: 140,
                    padding:
              const EdgeInsets.all(4),

          decoration: BoxDecoration(
            // color: Colors.deepPurple.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
height: value <= 0
    ? 5
    : value * 3,
               decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade600)
            ),
          ),
        ),
         const SizedBox(height: 10),

        /// PERCENTAGE
        Text(
          "${value.toInt()}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
 const SizedBox(height: 4),

        /// LABEL
        Text(

          label,

          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final int count;

  const _Card({
    required this.title,
    required this.count,
  });

  // IconData getIcon() {
  //   switch (title) {
  //     case "Open Positions":
  //       return Icons.work_outline;
  //     case "New Applications":
  //       return Icons.description_outlined;
  //     case "Interviews Today":
  //       return Icons.calendar_today;
  //     case "Offers Pending":
  //       return Icons.timelapse;
  //     case "Hired This Month":
  //       return Icons.person;
  //     default:
  //       return Icons.cancel;
  //   }
  // }
  IconData getIcon() {
  switch (title) {
    case "Open Positions":
      return Icons.work_outline_rounded;

    case "New Applications":
      return Icons.description_outlined;

    case "Candidates":
      return Icons.groups_outlined;

    default:
      return Icons.dashboard_outlined;
  }
}

 Color getColor() {
  switch (title) {
    case "Open Positions":
      return Colors.blue;

    case "New Applications":
      return Colors.orange;

    case "Candidates":
      return Colors.green;

    default:
      return Colors.grey;
  }
}
@override
Widget build(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 140, // 👈 control card height
    padding: const EdgeInsets.all(16),
 decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(18),  
  border: Border.all(
    color: Colors.grey.shade300,
  ),
  boxShadow: [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 20,
      offset: Offset(0, 10),
    ),
     BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 20,
      offset: Offset(0, 10),
    ),
  ],
),

//     decoration: BoxDecoration(
//   gradient: LinearGradient(
//     colors: [
//       getColor().withOpacity(.15),
//       Colors.white,
//     ],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   ),
//   borderRadius: BorderRadius.circular(22),
//   border: Border.all(
//     color: Colors.grey.shade400,
//   ),
//   boxShadow: [
//     BoxShadow(
//       color: getColor().withOpacity(.08),
//       blurRadius: 15,
//       offset: const Offset(0, 8),
//     ),
//   ],
// ),
    child: Column(

  crossAxisAlignment:
      CrossAxisAlignment.start,

  children: [

    /// TITLE
    Text(

      title,

      style: const TextStyle(

        fontSize: 14,

        fontWeight:
            FontWeight.w500,
      ),

      maxLines: 2,

      overflow:
          TextOverflow.ellipsis,
    ),

    const Spacer(),

    /// ICON + NUMBER
    Row(

      children: [
        Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: getColor().withOpacity(.15),
    borderRadius: BorderRadius.circular(14),
    border: Border.all(
      color: getColor().withOpacity(.2),
    ),
  ),
  child: Icon(
    getIcon(),shadows: [Shadow(
      color: Colors.red,
    )],
    color: getColor(),
    size: 28,
  ),
),

        const SizedBox(width: 10),

        Text(

          "$count",

          style:
              const TextStyle(

            fontSize: 28,

            fontWeight:
                FontWeight.w500,
          ),
        ),
      ],
    ),
  ],
),
  );
}}
