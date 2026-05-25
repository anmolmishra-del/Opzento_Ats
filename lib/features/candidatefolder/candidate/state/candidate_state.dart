class CandidateState {
  final String selectedTab;
  final String searchQuery;

  final Map<String, int> tabCounts;

  final List<Candidate> candidates;

  const CandidateState({
    required this.selectedTab,
    required this.searchQuery,
    required this.tabCounts,
    required this.candidates,
  });

  factory CandidateState.initial() {
    return const CandidateState(
      selectedTab: "Applied",
      searchQuery: "",
      tabCounts: {
        "Applied": 23,
        "Screening": 10,
        "HR Round": 6,
        "Technical Round": 4,
        "Presentation": 2,
      },
      candidates: [
        Candidate(
          name: "Rahul Sharma",
          role: "Flutter Developer",
          stage: "Applied",
        ),
        Candidate(
          name: "Anjali Verma",
          role: "Backend Developer",
          stage: "Screening",
        ),
        Candidate(
          name: "John Doe",
          role: "UI/UX Designer",
          stage: "HR Round",
        ),
      ],
    );
  }

  CandidateState copyWith({
    String? selectedTab,
    String? searchQuery,
    Map<String, int>? tabCounts,
    List<Candidate>? candidates,
  }) {
    return CandidateState(
      selectedTab: selectedTab ?? this.selectedTab,
      searchQuery: searchQuery ?? this.searchQuery,
      tabCounts: tabCounts ?? this.tabCounts,
      candidates: candidates ?? this.candidates,
    );
  }
}

class Candidate {
  final String name;
  final String role;
  final String stage;

  const Candidate({
    required this.name,
    required this.role,
    required this.stage,
  });
}





// class CandidateState {

//   final String selectedTab;

//   final String searchQuery;

//   final Map<String, int> tabCounts;

//   final List<Candidate> candidates;

//   const CandidateState({
//     required this.selectedTab,
//     required this.searchQuery,
//     required this.tabCounts,
//     required this.candidates,
//   });

//   factory CandidateState.initial() {

//     return const CandidateState(

//       selectedTab: "Applied",

//       searchQuery: "",

//       // dynamic counts
//       tabCounts: {},

//       // dynamic candidate list
//       candidates: [],
//     );
//   }

//   CandidateState copyWith({

//     String? selectedTab,

//     String? searchQuery,

//     Map<String, int>? tabCounts,

//     List<Candidate>? candidates,

//   }) {

//     return CandidateState(

//       selectedTab:
//           selectedTab ??
//               this.selectedTab,

//       searchQuery:
//           searchQuery ??
//               this.searchQuery,

//       tabCounts:
//           tabCounts ??
//               this.tabCounts,

//       candidates:
//           candidates ??
//               this.candidates,
//     );
//   }
// }

// class Candidate {

//   final String name;

//   final String role;

//   final String stage;

//   const Candidate({

//     required this.name,

//     required this.role,

//     required this.stage,
//   });
// }
