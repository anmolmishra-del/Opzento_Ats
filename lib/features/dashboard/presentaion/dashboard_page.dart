import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/core/constants/app_colors.dart';
import 'package:opsento_ats/features/notification/presention/notification_page.dart';
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
        backgroundColor: Colors.white,
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
                      Row(
                        children: [
                          const CircleAvatar(radius: 24),
                          const SizedBox(width: 12),
                          const Text(
                            "Dashboard",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.notifications_none, size: 28),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const NotificationsPage(),
                                ),
                              );
                            },
                          ),
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

                      const SizedBox(height: 20),

                      // const Text(
                      //   "Tuesday, 14 May 2024",
                      //   style: TextStyle(color: Colors.grey),
                      // ),

                      const SizedBox(height: 25),

                      // ERROR UI
                      if (state.error != null)
                        Text(
                          state.error!,
                          style: const TextStyle(color: Colors.red),
                        ),

                      // GRID
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.titles.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.6,
                        ),
                        itemBuilder: (context, index) {
                          return _Card(
                            title: state.titles[index],
                            count: state.counts[index],
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // FILTER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Hiring Funnel",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.changeFilter("This Month");
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(state.selectedFilter),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // LOADING
                      if (state.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        SizedBox(
                          height: 220,
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
    //                           children: state.chartValues
    // .map((h) => _ChartBar(height: h))
    // .toList(),

  _ChartBar(
    percentage: 90,
    label: "Applied",
  ),

  _ChartBar(
    percentage: 70,
    label: "Screening",
  ),

  _ChartBar(
    percentage: 55,
    label: "Interview",
  ),

  _ChartBar(
    percentage: 35,
    label: "Offer",
  ),

  _ChartBar(
    percentage: 20,
    label: "Hired",
  ),
],
                          ),
                        ),

                      const SizedBox(height: 20),

                      // ElevatedButton(
                      //   onPressed: cubit.refreshDashboard,
                      //   child: const Text("Refresh"),
                      // ),
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
  final double percentage;

  final String label;
  const _ChartBar({super.key, 
    required this.percentage,

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
height: 140 * (percentage / 100),            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade600)
            ),
          ),
        ),
         const SizedBox(height: 10),

        /// PERCENTAGE
        Text(

          "${percentage.toInt()}%",

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

  IconData getIcon() {
    switch (title) {
      case "Open Positions":
        return Icons.work_outline;
      case "New Applications":
        return Icons.description_outlined;
      case "Interviews Today":
        return Icons.calendar_today;
      case "Offers Pending":
        return Icons.timelapse;
      case "Hired This Month":
        return Icons.person;
      default:
        return Icons.cancel;
    }
  }

  Color getColor() {
    switch (title) {
      case "Open Positions":
      case "New Applications":
        return Colors.deepPurple;
      case "Interviews Today":
      case "Hired This Month":
        return Colors.green;
      case "Offers Pending":
        return Colors.orange;
      default:
        return Colors.red;
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
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 10,
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ICON
        Center(child: Icon(getIcon(), color: getColor(), size: 32)),

        const SizedBox(width: 12),

        // TEXT SECTION
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, // 👈 vertical center
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 6),

              Text(
                "$count",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}}