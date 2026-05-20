class JobState {

  final String selectedTab;
  final String searchQuery;

  final List<JobData> jobs;

  const JobState({
    required this.selectedTab,
    required this.searchQuery,
    required this.jobs,
  });

  factory JobState.initial() {

    return JobState(
      selectedTab: "All",
      searchQuery: "",
      jobs: [],
    );
  }

  JobState copyWith({
    String? selectedTab,
    String? searchQuery,
    List<JobData>? jobs,
  }) {

    return JobState(
      selectedTab:
          selectedTab ?? this.selectedTab,

      searchQuery:
          searchQuery ?? this.searchQuery,

      jobs: jobs ?? this.jobs,
    );
  }
}

class JobData {

  final String title;
  final String department;

  final String experience;
  final String location;

  final String salary;
  final String type;
<<<<<<< HEAD
 final List<String> primarySkills;

  final List<String> secondarySkills;
=======

>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
  final String status;

  final int newCount;

  // NEW FIELDS

  final String description;

  final List<String> responsibilities;

  final List<String> requirements;

  const JobData({

    required this.title,

    required this.department,

    required this.experience,
<<<<<<< HEAD
    required this.primarySkills,

    required this.secondarySkills,
=======

>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
    required this.location,

    required this.salary,

    required this.type,

    this.status = "Open",

    this.newCount = 0,

    required this.description,

    required this.responsibilities,

    required this.requirements,
  });
}