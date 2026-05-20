import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/candidatefolder/candidate_screen/presentaion/candidate_page.dart';

import '../cubit/candidate_cubit.dart';
import '../state/candidate_state.dart';

class CandidatePage extends StatelessWidget {
  const CandidatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CandidateCubit(),
      child: Scaffold(
        body: BlocBuilder<CandidateCubit, CandidateState>(
          builder: (context, candidateState) {
            final cubit = context.read<CandidateCubit>();
            final tabCounts = candidateState.tabCounts;
            final searchLower = candidateState.searchQuery.toLowerCase();
            final filtered = candidateState.candidates.where((candidate) {
              final matchTab = candidate.stage == candidateState.selectedTab;
              final matchSearch = candidate.name.toLowerCase().contains(searchLower) ||
                  candidate.role.toLowerCase().contains(searchLower);
              return matchTab && matchSearch;
            }).toList();

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      onChanged: cubit.search,
                      decoration: InputDecoration(
                        hintText: "Search candidates...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: tabCounts.entries.map((entry) {
                          final isActive = candidateState.selectedTab == entry.key;
                          return GestureDetector(
                            onTap: () => cubit.changeTab(entry.key),
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: isActive ? Colors.deepPurple : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "${entry.key} (${entry.value})",
                                style: TextStyle(
                                  color: isActive ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final candidate = filtered[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CandidateProfilePage(),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    child: Icon(Icons.person),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          candidate.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(candidate.role),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      candidate.stage,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
