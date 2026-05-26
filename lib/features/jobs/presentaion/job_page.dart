import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/jobs/presentaion/create_job.dart';
import 'package:opsento_ats/features/jobs/presentaion/job_detils_page.dart';

import '../cubit/job_cubit.dart';
import '../state/job_state.dart';

class JobPage extends StatelessWidget {
  final bool isRecruiter;
  const JobPage({super.key,required this.isRecruiter});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => JobCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<JobCubit, JobState>(
              builder: (context, state) {
                final cubit = context.read<JobCubit>();
                // final bool isRecruiter = true;
                // FILTER LOGIC
                List<JobData> filteredJobs = state.jobs.where((job) {
                  final matchTab = state.selectedTab == "All"
                      ? true
                      : job.status == state.selectedTab;

                  final matchSearch = job.title
                      .toLowerCase()
                      .contains(state.searchQuery.toLowerCase());

                  return matchTab && matchSearch;
                }).toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                 // ROLE CHECK


Row(
  children: [

    const Text(
      "Jobs",
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),

    const Spacer(),

    // ONLY RECRUITER CAN SEE CREATE BUTTON
    if (isRecruiter)
      IconButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  BlocProvider.value(
                value:
                    context.read<JobCubit>(),

                child:
                    const CreateJobPage(),
              ),
            ),
          );
        },

        icon: const Icon(
          Icons.add_circle,
          size: 32,
        ),

        color: Colors.deepPurple,
      ),
  ],
),
                    const SizedBox(height: 12),

                    // SEARCH BAR
                    TextField(
                      onChanged: cubit.search,
                      decoration: InputDecoration(
                        hintText: "Search jobs...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // TABS
                   Row(

  mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

  children: [

    _tab(
      "All",
      state.selectedTab,
      cubit,
    ),

    _tab(
      "Open",
      state.selectedTab,
      cubit,
    ),

    // ONLY RECRUITER
    if (isRecruiter) ...[

      _tab(
        "Draft",
        state.selectedTab,
        cubit,
      ),

      _tab(
        "Closed",
        state.selectedTab,
        cubit,
      ),
    ],
  ],
),

                    const SizedBox(height: 20),

                    // JOB LIST
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredJobs.length,
                        itemBuilder: (context, index) {
                          final job = filteredJobs[index];

                          return InkWell(
                             borderRadius: BorderRadius.circular(14),
                              onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreateJobdetailsPage(job: job,isRecruiter: isRecruiter,),
      ),
    );
  },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.grey.shade300),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.deepPurple.shade100,
                                    child: const Icon(Icons.work),
                                  ),
                                  const SizedBox(width: 12),
                            
                                  // DETAILS
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          job.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(job.department),
                                      ],
                                    ),
                                  ),
                            
                                  // STATUS + COUNT
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: _statusColor(job.status),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          job.status,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text("${job.newCount} new"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _tab(String label, String selected, JobCubit cubit) {
    final isActive = label == selected;

    return GestureDetector(
      onTap: () => cubit.changeTab(label),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.deepPurple : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          if (isActive)
            Container(
              height: 3,
              width: 30,
              color: Colors.deepPurple,
            )
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Open":
        return Colors.green;
      case "Draft":
        return Colors.orange;
      case "Closed":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
