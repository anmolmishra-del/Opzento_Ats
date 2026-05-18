import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                        children: const [
                          CircleAvatar(radius: 24),
                          SizedBox(width: 12),
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.notifications_none, size: 30),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Tuesday, 14 May 2024",
                        style: TextStyle(color: Colors.grey),
                      ),

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
                          height: 160,
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: state.chartValues
                                .map((h) => _ChartBar(height: h))
                                .toList(),
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
  final double height;

  const _ChartBar({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: height,
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.bottomCenter,
      child: Container(
        height: height * 0.6,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
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
                  fontSize: 28,
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