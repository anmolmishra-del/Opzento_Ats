import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/candidatefolder/candidate_screen/presentaion/candidate_page.dart';
import 'package:opsento_ats/features/my_applications/cubit/my_application_cubit.dart';
import 'package:opsento_ats/features/my_applications/state/my_appication_state.dart';

import '../cubit/candidate_cubit.dart';
import '../state/candidate_state.dart';

class CandidatePage extends StatelessWidget {
  const CandidatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CandidateCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Candidates")),
        body: 
BlocBuilder<MyApplicationCubit, MyApplicationState>        (
         builder: (context, state) {

  final cubit =
      context.read<CandidateCubit>();

  final candidateState =
      cubit.state;

  final applications =
      state.applications;
      final tabCounts = {

  "Applied": applications
      .where((e) => e.status == "Applied")
      .length,

  "Screening": applications
      .where((e) => e.status == "Screening")
      .length,

  "HR Round": applications
      .where((e) => e.status == "HR Round")
      .length,

  "Technical Round": applications
      .where((e) => e.status == "Technical Round")
      .length,

  "Presentation": applications
      .where((e) => e.status == "Presentation")
      .length,
};

  final filtered =
      applications.where((c) {

    final matchTab =
        c.status ==
        candidateState.selectedTab;

    final matchSearch =
        c.title
            .toLowerCase()
            .contains(
              candidateState
                  .searchQuery
                  .toLowerCase(),
            );

    return matchTab &&
        matchSearch;

  }).toList();

  return Padding(
    padding: const EdgeInsets.all(16),

    child: Column(
      children: [

        // SEARCH BAR
        TextField(

          onChanged:
              cubit.search,

          decoration:
              InputDecoration(

            hintText:
                "Search candidates...",

            prefixIcon:
                const Icon(
              Icons.search,
            ),

            border:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                      12),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // TABS
        SingleChildScrollView(

          scrollDirection:
              Axis.horizontal,

          child: Row(

            children:
                // candidateState
                    tabCounts
                    .entries
                    .map((e) {

              final isActive =
                  candidateState
                          .selectedTab ==
                      e.key;

              return GestureDetector(

                onTap: () =>
                    cubit.changeTab(
                        e.key),

                child: Container(

                  margin:
                      const EdgeInsets
                          .only(
                    right: 10,
                  ),

                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),

                  decoration:
                      BoxDecoration(

                    color: isActive

                        ? Colors
                            .deepPurple

                        : Colors.grey
                            .shade200,

                    borderRadius:
                        BorderRadius
                            .circular(
                                20),
                  ),

                  child: Text(

                    "${e.key} (${e.value})",

                    style:
                        TextStyle(

                      color: isActive

                          ? Colors.white

                          : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 20),

        // LIST
        Expanded(
          child: ListView.builder(

            itemCount:
                filtered.length,

            itemBuilder:
                (context, index) {

              final c =
                  filtered[index];

              return InkWell(

                borderRadius:
                    BorderRadius
                        .circular(14),

                onTap: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                          const CandidateProfilePage(),
                    ),
                  );
                },

                child: Container(

                  margin:
                      const EdgeInsets
                          .only(
                    bottom: 12,
                  ),

                  padding:
                      const EdgeInsets
                          .all(14),

                  decoration:
                      BoxDecoration(

                    color:
                        Colors.white,

                    borderRadius:
                        BorderRadius
                            .circular(
                                14),

                    boxShadow: [

                      BoxShadow(
                        color: Colors
                            .grey
                            .shade200,

                        blurRadius:
                            10,
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      const CircleAvatar(
                        child: Icon(
                          Icons.person,
                        ),
                      ),

                      const SizedBox(
                          width: 12),

                      Expanded(
                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(
                              c.title,

                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            Text(
                              c.company,
                            ),
                          ],
                        ),
                      ),

                      Container(

                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),

                        decoration:
                            BoxDecoration(

                          color: Colors
                              .deepPurple,

                          borderRadius:
                              BorderRadius
                                  .circular(
                                      8),
                        ),

                        child: Text(

                          c.status,

                          style:
                              const TextStyle(
                            color:
                                Colors.white,
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
  );
})));}}