class DashboardState {
  final bool isLoading;
  final String? error;

  final String selectedFilter;

  final List<String> titles;
  final List<int> counts;
  final List<double> chartValues;
final String name;  
const DashboardState({
    required this.isLoading,
    required this.error,
    required this.selectedFilter,
    required this.titles,
    required this.counts,
    required this.chartValues,
    required this.name,
  });

  factory DashboardState.initial() {
    return  DashboardState(
name: "",
  isLoading: false,

  error: null,

  selectedFilter: "This Month",

  titles: [

    "Open Positions",

    "New Applications",

    "Interviews Today",

    "Offers Pending",

    "Hired This Month",
      "Rejected",
  ],

  counts: [

  ],

  chartValues: [

 
  ],
); }

  DashboardState copyWith({
    bool? isLoading,
    String? error,
    String? selectedFilter,
    List<String>? titles,
    List<int>? counts,
    List<double>? chartValues,
    String? name,
  }) {
    return DashboardState(
      name:
    name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      titles: titles ?? this.titles,
      counts: counts ?? this.counts,
      chartValues: chartValues ?? this.chartValues,
    );
  }
}
